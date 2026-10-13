# Clears the cake in this block and in every block above it up to the first
#  without
# Run at the bottom of the block a placement stands in

fill ~ ~ ~ ~ ~ ~ air replace #derailed:pile_collision strict
execute positioned ~ ~1 ~ if block ~ ~ ~ #derailed:pile_collision run function derailed:placement/_clear_collision
