# On datapack load

# Objectives are split by LIFETIME, not by what the value means. The rule:
#   am I handing this to a function I am about to call?  -> dr_arg
#   does it outlive this operation?                      -> dr_var
#   neither?                                             -> dr_temp
# Macro parameters are just arguments that get copied to storage on the way, so
#  they live in dr_arg too rather than an objective of their own
scoreboard objectives add dr_const dummy "DeRailed Constants"
scoreboard objectives add dr_config dummy "DeRailed Configs"
scoreboard objectives add dr_var dummy "DeRailed Persistent State"
scoreboard objectives add dr_arg dummy "DeRailed Function Arguments"
scoreboard objectives add dr_temp dummy "DeRailed Function-Local Scratch"

# Item system
scoreboard objectives add dr_count dummy "DeRailed Item Counts"

# Every item is a panda spawn egg, and breaking a block with one that is a tool
#  counts as using it, so this goes up for the player who broke a tile's block
scoreboard objectives add dr_tool_used minecraft.used:minecraft.panda_spawn_egg "DeRailed Tool Used"

# Owner id. Held by BOTH players and the markers/placements they create, so ownership
#  is a direct score comparison with no macro and no proximity guess
scoreboard objectives add dr_player_id dummy "DeRailed Owner Id"
scoreboard players add $NextPid dr_var 0

# Item type, shared by markers, placements and held stacks
scoreboard objectives add dr_item dummy "DeRailed Item Type"

# Dash
scoreboard objectives add dr_dash_cd dummy "DeRailed Dash Cooldown"
scoreboard objectives add dr_dash_burst dummy "DeRailed Dash Burst"

# Mining, held by the marker on each tree and iron tile: the stage the tile is
#  in and which variant of its structures it is drawn with
scoreboard objectives add dr_mine_stage dummy "DeRailed Mining Stage"
scoreboard objectives add dr_mine_variant dummy "DeRailed Mining Variant"

# Trains: the piece every part of a train belongs to, for each axle the tile
#  of the track it is on, how far into it, and that tile's middle, the ways in
#  and out of it and its length, and for each piece how far it has gone, which
#  its wheels turn by, all lengths in thousandths of a block
scoreboard objectives add dr_tid dummy "DeRailed Train Piece"
scoreboard objectives add dr_ai dummy "DeRailed Axle Tile"
scoreboard objectives add dr_ad dummy "DeRailed Axle Distance"
scoreboard objectives add dr_acx dummy "DeRailed Axle Tile X"
scoreboard objectives add dr_acz dummy "DeRailed Axle Tile Z"
scoreboard objectives add dr_adin dummy "DeRailed Axle Way In"
scoreboard objectives add dr_adout dummy "DeRailed Axle Way Out"
scoreboard objectives add dr_alen dummy "DeRailed Axle Tile Length"
scoreboard objectives add dr_spin dummy "DeRailed Train Distance"

# The hundredth of water used the water wagon's tank was last drawn at
scoreboard objectives add dr_water_step dummy "DeRailed Water Step"

# Mounds, held by the markers 'mound/build' lays on each tile and corner
scoreboard objectives add dr_mi dummy "DeRailed Mound Of Kind"
scoreboard objectives add dr_md dummy "DeRailed Mound Depth"
scoreboard objectives add dr_mh dummy "DeRailed Mound Height"
scoreboard objectives add dr_mx dummy "DeRailed Mound Column"
scoreboard objectives add dr_mz dummy "DeRailed Mound Row"

# Config defaults
execute unless score $HandCap dr_config matches 1.. run scoreboard players set $HandCap dr_config 3
execute unless score $BucketFillTicks dr_config matches 1.. run scoreboard players set $BucketFillTicks dr_config 20

# The map's limits, which the search for a spot for a pile stays inside until
#  a map sets its own: the blocks across it, and the lowest and highest block
#  a pile can stand in, over the ground at y14 and over the highest rock at y29
execute unless score $MapMinX dr_var = $MapMinX dr_var run scoreboard players set $MapMinX dr_var 1100
execute unless score $MapMaxX dr_var = $MapMaxX dr_var run scoreboard players set $MapMaxX dr_var 1195
execute unless score $MapMinZ dr_var = $MapMinZ dr_var run scoreboard players set $MapMinZ dr_var 0
execute unless score $MapMaxZ dr_var = $MapMaxZ dr_var run scoreboard players set $MapMaxZ dr_var 47
execute unless score $MapMinY dr_var = $MapMinY dr_var run scoreboard players set $MapMinY dr_var 15
execute unless score $MapMaxY dr_var = $MapMaxY dr_var run scoreboard players set $MapMaxY dr_var 30

# How far a train goes along its track a tick, in thousandths of a block: 15 is
#  0.1 tiles a second
execute unless score $TrainSpeed dr_config matches 0.. run scoreboard players set $TrainSpeed dr_config 15

# How many ticks a full water wagon lasts before it catches fire
execute unless score $WaterTicks dr_config matches 1.. run scoreboard players set $WaterTicks dr_config 2400

# How many ticks of water a train uses before it can be refilled
execute unless score $RefillWait dr_config matches 0.. run scoreboard players set $RefillWait dr_config 500

# Ticks the dash lasts, and how long until it can be used again
execute unless score $DashBurst dr_config matches 1.. run scoreboard players set $DashBurst dr_config 4
execute unless score $DashCooldown dr_config matches 1.. run scoreboard players set $DashCooldown dr_config 40

# Offhand map enforcement stays off until the framebuffer map exists
execute unless score $MapEnabled dr_config matches 0..1 run scoreboard players set $MapEnabled dr_config 0

# Item ids are grouped so a single comparison tells the categories apart
#    1-9    resources, which stack to $HandCap and are consumed
#    10-19  equipment, carried one at a time, mining tools from $FirstTool up
#    20+    anything else
scoreboard players set $Wood dr_const 1
scoreboard players set $Iron dr_const 2
scoreboard players set $Rail dr_const 3
scoreboard players set $Axe dr_const 10
scoreboard players set $Pickaxe dr_const 11
scoreboard players set $Bucket dr_const 20

scoreboard players set $LastResource dr_const 9
scoreboard players set $FirstTool dr_const 10
scoreboard players set $LastTool dr_const 19

# A placed pile's layers in ten-thousandths of a block: wood's model is 9
#  pixels a layer, and iron's and rails', drawn twice their size, 12
scoreboard players set $WoodLayer dr_const 5625
scoreboard players set $ScaledLayer dr_const 7500
scoreboard players set $Pixel dr_const 625
scoreboard players set $TenThousand dr_const 10000
scoreboard players set $BatchHeight dr_const 3
scoreboard players set $RotationStep dr_const 90
scoreboard players set $HalfTurn dr_const 180

# A tile is three blocks across
scoreboard players set $TileSize dr_const 3

# A train's lengths are in thousandths of a block and its facings in
#  thousandths of a degree; a corner's quarter turn of half a tile is 2356 long
scoreboard players set $Four dr_const 4
scoreboard players set $Thousand dr_const 1000
scoreboard players set $HalfTile dr_const 1500
scoreboard players set $QuarterTurn dr_const 90000
scoreboard players set $CornerTurn dr_const 2356

# The water wagon's tank is white concrete tinted, a tint for each hundredth of
#  its water used: from the one that makes it look like light blue concrete,
#  full, to the one that makes it look like red concrete, dry, mixed in linear
#  light
scoreboard players set $Hundred dr_const 100
data modify storage derailed:train tank_tint set value [2925805,3187692,3384299,3580650,3777001,3973352,4169959,4300774,4497125,4628196,4759010,4955361,5086176,5217247,5348062,5478877,5609692,5674971,5806042,5936856,6067671,6132950,6264021,6329300,6460115,6525393,6656208,6721487,6852558,6917837,7048651,7113930,7179209,7310023,7375302,7440837,7571652,7636930,7702209,7767488,7898302,7963581,8028859,8094138,8159417,8224695,8355510,8420788,8486067,8551345,8616624,8681902,8747181,8812459,8877738,8943016,9008295,9073573,9138851,9204130,9269408,9334430,9399708,9464987,9530265,9595543,9660565,9725843,9791121,9856399,9921421,9921163,9986441,10051463,10116741,10181763,10247041,10312062,10377340,10376826,10442103,10507125,10572402,10637424,10702445,10701930,10767207,10832228,10897249,10962270,10961754,11026519,11091539,11156559,11155787,11220806,11285569,11350332,11415094,11414319,11478823]

gamerule random_tick_speed 0

# A search for a spot for a pile can run tens of thousands of commands where
#  nothing near is free, more than the default limit of 65536 a function chain
#  runs before the rest are dropped
gamerule max_command_sequence_length 1000000

function derailed:dev/bench/load
function derailed:dev/gen/load
function derailed:dev/hud/load

# Set the current version
data modify storage derailed:data Version set value "0.1"

# The game dimension only registers at world load, so a fresh install can't see
#  it until the world is reopened. Warn instead of failing silently
scoreboard players set #dimension_ok dr_var 0
execute in derailed:game run scoreboard players set #dimension_ok dr_var 1
execute if score #dimension_ok dr_var matches 0 run tellraw @a [{text:"[DeRailed] ",color:"red",bold:true},{text:"Dimension 'derailed:game' is not loaded. Close and re-open the world to finish installing.",color:"red",bold:false}]
