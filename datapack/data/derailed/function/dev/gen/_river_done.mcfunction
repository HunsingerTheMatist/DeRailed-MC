
# The river is made, so every tile still standing becomes the line to lay,
#  unless the line can be laid on no side of its corners without carving a
#  prefab, and then the way out is given up like a dead end
# Run as the head

scoreboard players set #riv_done dr_var 1

execute as @e[type=marker,tag=dr_riv_path,distance=0..] unless entity @s[tag=dr_riv_dead] run tag @s add dr_riv_line
function derailed:dev/gen/_river_shorten
execute if score #riv_side dr_var matches 0 run return run function derailed:dev/gen/_river_refuse

# What the river after this one is told about it; its length is counted once
#  it is laid
scoreboard players operation #riv_col_got dr_var = #riv_col_try dr_var
execute if score #riv_join dr_var matches 1 run scoreboard players add #riv_joins dr_var 1

function derailed:dev/gen/_river_show
