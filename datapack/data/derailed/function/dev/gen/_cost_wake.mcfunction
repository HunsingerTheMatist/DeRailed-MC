
# Steps onto a parked rock tile now that its level and wave have come, and
#  spreads from it like any other
# Run as the marker, positioned on it

tag @s remove dr_rock_wait
scoreboard players remove #cost_waiting dr_var 1

execute if entity @s[tag=dr_goal] run scoreboard players operation #cost_w dr_var = #cost_wave dr_var
execute if entity @s[tag=dr_goal] run return run function derailed:dev/gen/_cost_reach

scoreboard players add #cost_pending dr_var 1
function derailed:dev/gen/_cost_spread
