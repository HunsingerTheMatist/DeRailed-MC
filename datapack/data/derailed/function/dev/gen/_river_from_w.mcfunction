
# Sets out from the western border, facing into the section
scoreboard players set #riv_side dr_var 1
scoreboard players set #riv_dir dr_var 3
data modify storage derailed:gen v.c set value 0
execute store result storage derailed:gen v.r int 1 run random value 1..15
function derailed:dev/gen/_river_spot with storage derailed:gen v
