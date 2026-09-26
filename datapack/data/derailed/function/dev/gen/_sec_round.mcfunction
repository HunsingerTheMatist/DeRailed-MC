
# Spreads the search from every tile reached cutting '#sec_lvl' rock tiles and
#  running '#sec_rd', then from those one tile further, and once the level is
#  spent from the tiles one rock tile further, until nothing is left

execute as @e[type=marker,tag=dr_bq,tag=!dr_bdone,distance=0..] if score @s dr_rock = #sec_lvl dr_var if score @s dr_depth = #sec_rd dr_var at @s run function derailed:dev/gen/_sec_expand_as

scoreboard players add #sec_rd dr_var 1
execute if score #sec_rd dr_var <= #gen_detour_max dr_var run return run function derailed:dev/gen/_sec_round

scoreboard players add #sec_lvl dr_var 1
scoreboard players set #sec_rd dr_var 1
execute if score #sec_lvl dr_var matches ..20 if entity @e[type=marker,tag=dr_bq,tag=!dr_bdone,distance=0..] run function derailed:dev/gen/_sec_round
