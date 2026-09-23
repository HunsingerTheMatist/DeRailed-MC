
# Takes the next kind still owed to a floor, in a fixed order with rock last
# The order costs nothing, since the seed it lands on is a random one anyway,
#  and rock going last is what keeps it off a seed the track runs through if a
#  long enough chain ever reaches this far: such a seed owed only rock draws as
#  usual and the rock floor goes short
# Run as the seed

execute if score #kind_owe_wood dr_var matches 1.. run return run scoreboard players set #gen_kind dr_var 1
execute if score #kind_owe_iron dr_var matches 1.. run return run scoreboard players set #gen_kind dr_var 2
execute if score #kind_owe_water dr_var matches 1.. run return run scoreboard players set #gen_kind dr_var 3
execute unless entity @s[tag=dr_chain] if score #kind_owe_rock dr_var matches 1.. run return run scoreboard players set #gen_kind dr_var 4
function derailed:dev/gen/_kind_draw
