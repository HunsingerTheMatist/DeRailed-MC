
# Shows everything the river did not end up taking in red: the branches the search
#  gave up on, and the loops the walk cut out

# This only ever touches the copy the river is cut into, so the blocks the regions
#  grew as are left to be read whatever gets drawn here
# A branch is shown at the corner it stood on while the water goes on one of the
#  tiles flanking it, so the two do land on each other, and where they do the
#  water is left alone: it is the one that should be seen
execute as @e[type=marker,tag=dr_riv_path,distance=0..] unless entity @s[tag=dr_riv_keep] at @s unless block ~ ~ ~ air unless block ~ ~9 ~ magenta_glazed_terracotta run setblock ~ ~9 ~ red_glazed_terracotta strict
