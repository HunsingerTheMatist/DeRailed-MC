
# Lays a test track and puts an engine, a supply wagon and a water wagon on it,
#  going round it for as long as they are left: a loop of tiles six across and
#  three down, an S bend at its western end, the train setting off east along
#  the bottom row
#   # V < < < <
#   V < # # # ^
#   > > > > > ^
# Run by a player standing where the track's northwestern corner goes; it takes
#  the 18 by 9 blocks south and east of there, on grass a block below

function derailed:dev/train/clear
fill ~ ~-1 ~ ~17 ~-1 ~8 grass_block strict
fill ~ ~ ~ ~17 ~3 ~8 air strict
execute align xyz summon marker run function derailed:dev/train/_origin

# The path runs a tile at a time, each tile's ways in and out 0 north, 1 east,
#  2 south and 3 west
data modify storage derailed:train path set value []
function derailed:dev/train/_tile {x:0,z:6,din:2,dout:1}
function derailed:dev/train/_tile {x:3,z:6,din:1,dout:1}
function derailed:dev/train/_tile {x:6,z:6,din:1,dout:1}
function derailed:dev/train/_tile {x:9,z:6,din:1,dout:1}
function derailed:dev/train/_tile {x:12,z:6,din:1,dout:1}
function derailed:dev/train/_tile {x:15,z:6,din:1,dout:0}
function derailed:dev/train/_tile {x:15,z:3,din:0,dout:0}
function derailed:dev/train/_tile {x:15,z:0,din:0,dout:3}
function derailed:dev/train/_tile {x:12,z:0,din:3,dout:3}
function derailed:dev/train/_tile {x:9,z:0,din:3,dout:3}
function derailed:dev/train/_tile {x:6,z:0,din:3,dout:3}
function derailed:dev/train/_tile {x:3,z:0,din:3,dout:2}
function derailed:dev/train/_tile {x:3,z:3,din:2,dout:3}
function derailed:dev/train/_tile {x:0,z:3,din:3,dout:2}
data modify storage derailed:train loop set from storage derailed:train path

# The train sets off with its water full, '$WaterTicks' until it catches fire
scoreboard players operation $WaterCap dr_var = $WaterTicks dr_config
scoreboard players set $WaterUsed dr_var 0

# Each piece's middle along the path, the engine in front, 4.5 between it and
#  the wagon behind and 3 between wagons
scoreboard players set #train_s dr_temp 9500
function derailed:train/spawn_engine
scoreboard players set #train_s dr_temp 5000
function derailed:train/spawn_supply
scoreboard players set #train_s dr_temp 2000
function derailed:train/spawn_water

# The train's ends half a block inside the outer edges of its shulkers: 1.05
#  ahead of the engine's front axle and 0.15 behind the water wagon's back axle
scoreboard players set #train_front_s dr_temp 11750
scoreboard players set #train_back_s dr_temp 1250
function derailed:train/spawn_reach
