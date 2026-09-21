
# Turns ground seeds into wood until the section has four of them

execute store result score #gen_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute if score #gen_n dr_var matches 4.. run return 0

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_tries dr_var matches ..0 run return fail

# Drawn at random rather than by distance: taking the nearest to the corner the
#  section is positioned at would gather every topped up region into one end of it
execute as @n[type=marker,tag=dr_seed,scores={dr_kind=0},distance=0..,sort=random] run scoreboard players set @s dr_kind 1
function derailed:dev/gen/_top_wood
