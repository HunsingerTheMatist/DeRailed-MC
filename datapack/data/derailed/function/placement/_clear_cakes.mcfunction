# Clears the cakes from this block, and from each block above it '#clear_left'
#  reaches into, whether or not the blocks between still hold them
# Run at the bottom of the block a placement stands in

fill ~ ~ ~ ~ ~ ~ air replace #derailed:pile_collision strict
scoreboard players remove #clear_left dr_temp 10000
execute if score #clear_left dr_temp matches 1.. positioned ~ ~1 ~ run function derailed:placement/_clear_cakes
