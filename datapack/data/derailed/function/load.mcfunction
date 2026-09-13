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

# Owner id. Held by BOTH players and the markers/placements they create, so ownership
#  is a direct score comparison with no macro and no proximity guess
scoreboard objectives add dr_player_id dummy "DeRailed Owner Id"
scoreboard players add $NextPid dr_var 0

# Item type, shared by markers, placements and held stacks
scoreboard objectives add dr_item dummy "DeRailed Item Type"

# Dash
scoreboard objectives add dr_dash_cd dummy "DeRailed Dash Cooldown"
scoreboard objectives add dr_dash_burst dummy "DeRailed Dash Burst"

# Config defaults
execute unless score $HandCap dr_config matches 1.. run scoreboard players set $HandCap dr_config 3
execute unless score $BucketFillTicks dr_config matches 1.. run scoreboard players set $BucketFillTicks dr_config 20

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

scoreboard players set $PlacementHeight dr_const 38
scoreboard players set $BatchHeight dr_const 3
scoreboard players set $RotationStep dr_const 90
scoreboard players set $HalfTurn dr_const 180

gamerule random_tick_speed 0

# Set the current version
data modify storage derailed:data Version set value "0.1"

# The game dimension only registers at world load, so a fresh install can't see
#  it until the world is reopened. Warn instead of failing silently
scoreboard players set #dimension_ok dr_var 0
execute in derailed:game run scoreboard players set #dimension_ok dr_var 1
execute if score #dimension_ok dr_var matches 0 run tellraw @a [{text:"[DeRailed] ",color:"red",bold:true},{text:"Dimension 'derailed:game' is not loaded. Close and re-open the world to finish installing.",color:"red",bold:false}]
