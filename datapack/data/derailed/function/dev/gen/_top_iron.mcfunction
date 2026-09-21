
# Turns ground seeds into iron until the section has four of them

execute store result score #gen_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]
execute if score #gen_n dr_var matches 4.. run return 0

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_tries dr_var matches ..0 run return fail

execute as @n[type=marker,tag=dr_seed,scores={dr_kind=0},distance=0..,sort=random] run scoreboard players set @s dr_kind 2
function derailed:dev/gen/_top_iron
