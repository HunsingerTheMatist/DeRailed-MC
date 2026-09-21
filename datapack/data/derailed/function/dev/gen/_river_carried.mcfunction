
# Sets out from the very corner the river of the section before left by, which is
#  what makes the two join squarely rather than at a diagonal
# Taken up once: if nothing can be made of it, the section falls back to a side
#  of its own

scoreboard players set #riv_carry dr_var 0
scoreboard players set #riv_forced dr_var 1
scoreboard players add #riv_joins dr_var 1
scoreboard players set #riv_side dr_var 1
scoreboard players set #riv_dir dr_var 3

data modify storage derailed:gen v.c set value 0
execute store result storage derailed:gen v.r int 1 run scoreboard players get #riv_carry_row dr_var
function derailed:dev/gen/_river_spot with storage derailed:gen v

# No boundary runs inland from there, so there was nothing to pick up
execute if score #riv_done dr_var matches 0 if score #riv_best dr_var matches 0 run scoreboard players add #riv_no_join dr_var 1
scoreboard players set #riv_forced dr_var 0

execute if score #riv_done dr_var matches 0 run function derailed:dev/gen/_river_try
