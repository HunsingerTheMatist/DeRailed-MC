
# Turns ground seeds into water until the section has two of them

execute store result score #gen_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=3},distance=0..]
execute if score #gen_n dr_var matches 2.. run return 0

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_tries dr_var matches ..0 run return fail

execute as @n[type=marker,tag=dr_seed,scores={dr_kind=0},distance=0..,sort=random] run scoreboard players set @s dr_kind 3
function derailed:dev/gen/_top_water
