
# Sends a section laid again for the wall's sake back to its attempts, the
#  attempts it has left as they were, and counts it
# Positioned at the section's corner

execute if score #gen_difficulty dr_var matches 2 run scoreboard players add #gen_wall_relaid dr_var 1
scoreboard players set #q_relay dr_var 0

# Painting swaps each region's own block for its kind, so the next attempt
#  has the regions laid out afresh to swap
clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict
scoreboard players set #q_step dr_var 10
return 1
