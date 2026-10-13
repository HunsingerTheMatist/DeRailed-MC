# Sets a cake in this block, '#cake_at' up from the block a placement stands
#  in, when it is from '#cake_from' and under '#cake_to', and goes on up to
#  '#cake_to'
# Run at the bottom of a block

execute if score #cake_at dr_temp >= #cake_to dr_temp run return 0
execute if score #cake_at dr_temp >= #cake_from dr_temp run setblock ~ ~ ~ cake strict
scoreboard players add #cake_at dr_temp 1
execute positioned ~ ~1 ~ run function derailed:placement/_add_cakes
