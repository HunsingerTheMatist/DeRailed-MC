
# Turns ground seeds into rock until the section has four of them

execute store result score #gen_n dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=4},distance=0..]
execute if score #gen_n dr_var matches 4.. run return 0

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_tries dr_var matches ..0 run return fail

# The seeds the track runs through are left out of it, the same as they are left
#  out of the roll: rock is the one kind that closes the corridor rather than
#  costing something to cross
execute as @n[type=marker,tag=dr_seed,tag=!dr_chain,scores={dr_kind=0},distance=0..,sort=random] run scoreboard players set @s dr_kind 4
function derailed:dev/gen/_top_rock
