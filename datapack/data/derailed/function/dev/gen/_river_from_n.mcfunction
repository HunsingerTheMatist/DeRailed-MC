
# Sets out from the northern border, facing into the section

scoreboard players set #riv_side dr_var 2
scoreboard players set #riv_dir dr_var 0

execute store result score #riv_col_try dr_var run random value 1..31 derailed:gen
function derailed:dev/gen/_river_apart
execute if score #riv_apart dr_var matches 0 run return fail

execute store result storage derailed:gen v.c int 1 run scoreboard players get #riv_col_try dr_var
data modify storage derailed:gen v.r set value 0
function derailed:dev/gen/_river_spot with storage derailed:gen v
