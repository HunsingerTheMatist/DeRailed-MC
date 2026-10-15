# Returns 1 when this block is open ground for a rail, fail otherwise: free to
#  place in, a placement there included, over a whole floor block
# Run at the middle of the block

execute unless block ~ ~-1 ~ #derailed:pile_floor run return fail
execute if block ~ ~-1 ~ #minecraft:slabs[type=bottom] run return fail
execute if block ~ ~-1 ~ #minecraft:stairs[half=bottom] run return fail
execute unless block ~ ~ ~ #derailed:valid_placements run return fail
return 1
