
# Tries every change that turns a region into the kind '#rep_w': any region
#  within reach of another kind, never rock, a wall, a lake, or one the first
#  route runs through, since that would change what the route was judged to
#  cost, unless it is the other resource, which the route pays the same for
# Positioned at the section's corner

scoreboard players set #rep_o dr_var 3
scoreboard players operation #rep_o dr_var -= #rep_w dr_var
execute as @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_wall,tag=!dr_lake,tag=!dr_on_first,distance=0..] unless score @s dr_kind = #rep_w dr_var run function derailed:dev/gen/_rep_try_a
execute as @e[type=marker,tag=dr_seed,tag=dr_reach,tag=dr_on_first,distance=0..] if score @s dr_kind = #rep_o dr_var run function derailed:dev/gen/_rep_try_a
