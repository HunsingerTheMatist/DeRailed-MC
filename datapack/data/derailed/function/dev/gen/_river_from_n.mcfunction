
# Sets out from the northern border, facing into the section
scoreboard players set #riv_side dr_var 2
scoreboard players set #riv_dir dr_var 0
execute store result storage derailed:gen v.c int 1 run random value 1..47
data modify storage derailed:gen v.r set value 0
function derailed:dev/gen/_river_spot with storage derailed:gen v
