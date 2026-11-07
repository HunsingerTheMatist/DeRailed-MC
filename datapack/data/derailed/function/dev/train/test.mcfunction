# Lays a test track for team $(team) and puts its engine, water wagon, supply
#  wagon and crafting wagon on it, going round it for as long as they are left,
#  in place of any train, track tiles and rails the team had: a loop of tiles
#  six across and three down, an S bend at its western end, the train setting
#  off east along the bottom row, each tile marked as a track tile
#   # V < < < <
#   V < # # # ^
#   > > > > > ^
# Run by a player standing where the track's northwestern corner goes; it takes
#  the 18 by 9 blocks south and east of there, on grass a block below

$function derailed:dev/train/clear {team:$(team)}
fill ~ ~-1 ~ ~17 ~-1 ~8 grass_block strict
fill ~ ~ ~ ~17 ~3 ~8 air strict
$scoreboard players set #train_team dr_temp $(team)
function derailed:dev/track/clear

# The train runs 0.2 above the corner's block
execute align xyz summon marker run function derailed:dev/train/_origin
scoreboard players operation #t dr_temp = #oy dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
$execute store result storage derailed:train t$(team).y int 1 run scoreboard players add #t dr_temp 200

# Piles put down round it are put down as on the map
scoreboard players operation #wx0 dr_temp = #ox dr_temp
scoreboard players operation #wx1 dr_temp = #ox dr_temp
scoreboard players add #wx1 dr_temp 17
scoreboard players operation #wz0 dr_temp = #oz dr_temp
scoreboard players operation #wz1 dr_temp = #oz dr_temp
scoreboard players add #wz1 dr_temp 8
scoreboard players operation #wy dr_temp = #oy dr_temp
function derailed:dev/widen_map

# The path runs a tile at a time, each tile's ways in and out 0 north, 1 east,
#  2 south and 3 west
$data modify storage derailed:train t$(team).path set value []
$function derailed:dev/train/_tile {team:$(team),x:0,z:6,din:2,dout:1}
$function derailed:dev/train/_tile {team:$(team),x:3,z:6,din:1,dout:1}
$function derailed:dev/train/_tile {team:$(team),x:6,z:6,din:1,dout:1}
$function derailed:dev/train/_tile {team:$(team),x:9,z:6,din:1,dout:1}
$function derailed:dev/train/_tile {team:$(team),x:12,z:6,din:1,dout:1}
$function derailed:dev/train/_tile {team:$(team),x:15,z:6,din:1,dout:0}
$function derailed:dev/train/_tile {team:$(team),x:15,z:3,din:0,dout:0}
$function derailed:dev/train/_tile {team:$(team),x:15,z:0,din:0,dout:3}
$function derailed:dev/train/_tile {team:$(team),x:12,z:0,din:3,dout:3}
$function derailed:dev/train/_tile {team:$(team),x:9,z:0,din:3,dout:3}
$function derailed:dev/train/_tile {team:$(team),x:6,z:0,din:3,dout:3}
$function derailed:dev/train/_tile {team:$(team),x:3,z:0,din:3,dout:2}
$function derailed:dev/train/_tile {team:$(team),x:3,z:3,din:2,dout:3}
$function derailed:dev/train/_tile {team:$(team),x:0,z:3,din:3,dout:2}
$data modify storage derailed:train t$(team).loop set from storage derailed:train t$(team).path

# Each piece's middle along the path, the engine in front, 4.5 between it and
#  the wagon behind and 3 between wagons
scoreboard players set #train_s dr_temp 12500
function derailed:train/spawn_engine
scoreboard players set #train_s dr_temp 8000
function derailed:train/spawn_water
scoreboard players set #train_s dr_temp 5000
function derailed:train/spawn_supply
scoreboard players set #train_s dr_temp 2000
function derailed:train/spawn_crafting

# The train's ends half a block inside the outer edges of its shulkers: 1.05
#  ahead of the engine's front axle and 0.15 behind the crafting wagon's back
#  axle
scoreboard players set #train_front_s dr_temp 14750
scoreboard players set #train_back_s dr_temp 1250
function derailed:train/spawn_reach
