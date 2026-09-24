
# Puts this region of the other resource up for repainting if that resource
#  would still have enough without it
# Run as the seed

scoreboard players operation #sup_spare dr_var = #sup_o dr_var
execute if entity @s[tag=dr_used] run scoreboard players operation #sup_spare dr_var -= @s dr_size
execute if score #sup_spare dr_var >= #need_o dr_var run tag @s add dr_cand
