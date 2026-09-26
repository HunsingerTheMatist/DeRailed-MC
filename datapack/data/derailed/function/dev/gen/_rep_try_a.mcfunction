
# Tries turning this region into '#rep_w': outright, where its own kind holds
#  more regions than its floor, and as a swap with every region of '#rep_w'
#  within reach that the first route does not run through, which takes this
#  region's kind in return
# Run as the region's seed, positioned at the section's corner

tag @s add rep_cur
scoreboard players operation #rep_k dr_var = @s dr_kind

scoreboard players set #rep_ok dr_var 1
execute if score #rep_k dr_var matches 1 if score #cnt_wood dr_var <= #gen_min_wood dr_var run scoreboard players set #rep_ok dr_var 0
execute if score #rep_k dr_var matches 2 if score #cnt_iron dr_var <= #gen_min_iron dr_var run scoreboard players set #rep_ok dr_var 0
execute if score #rep_k dr_var matches 3 if score #cnt_water dr_var <= #gen_min_water dr_var run scoreboard players set #rep_ok dr_var 0
execute if score #rep_ok dr_var matches 1 run function derailed:dev/gen/_rep_eval_paint

execute as @e[type=marker,tag=dr_seed,tag=dr_supply,tag=!dr_on_first,distance=0..] if score @s dr_kind = #rep_w dr_var run function derailed:dev/gen/_rep_eval_swap

tag @s remove rep_cur
