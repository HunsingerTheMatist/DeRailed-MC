# Returns 1 when this block is open ground for a rail, fail otherwise: free to
#  place in, or holding a placement, which it tags 'dr_shift' to be moved
#  aside, over a whole floor block
# Run at the middle of the block

execute unless block ~ ~-1 ~ #derailed:pile_floor run return fail
execute if block ~ ~-1 ~ #minecraft:slabs[type=bottom] run return fail
execute if block ~ ~-1 ~ #minecraft:stairs[half=bottom] run return fail
execute unless block ~ ~ ~ #derailed:valid_placements run return fail
execute positioned ~-0.5 ~-0.5 ~-0.5 run tag @e[type=interaction,tag=dr_placement,dx=0,dy=0,dz=0] add dr_shift
return 1
