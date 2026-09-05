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

# Owner id. Held by BOTH players and the markers/piles they create, so ownership
#  is a direct score comparison with no macro and no proximity guess
scoreboard objectives add dr_player_id dummy "DeRailed Owner Id"
scoreboard players add $NextPid dr_var 0

# Resource type, shared by markers, piles and held stacks
scoreboard objectives add dr_resource dummy "DeRailed Resource Type"

# Config defaults
execute unless score $HandCap dr_config matches 1.. run scoreboard players set $HandCap dr_config 3
execute unless score $BucketFillTicks dr_config matches 1.. run scoreboard players set $BucketFillTicks dr_config 40

# Offhand map enforcement stays off until the framebuffer map exists
execute unless score $MapEnabled dr_config matches 0..1 run scoreboard players set $MapEnabled dr_config 0

scoreboard players set $Wood dr_const 1
scoreboard players set $Iron dr_const 2
scoreboard players set $Rail dr_const 3
scoreboard players set $Bucket dr_const 4

scoreboard players set $ResourcePhysicalHeight dr_const 45
scoreboard players set $ResourceBatchHeight dr_const 3
scoreboard players set $RotationStep dr_const 90
scoreboard players set $HalfTurn dr_const 180

# Set the current version
data modify storage derailed:data Version set value "0.1"

# The game dimension only registers at world load, so a fresh install can't see
#  it until the world is reopened. Warn instead of failing silently
scoreboard players set #dimension_ok dr_var 0
execute in derailed:game run scoreboard players set #dimension_ok dr_var 1
execute if score #dimension_ok dr_var matches 0 run tellraw @a [{text:"[DeRailed] ",color:"red",bold:true},{text:"Dimension 'derailed:game' is not loaded. Close and re-open the world to finish installing.",color:"red",bold:false}]
