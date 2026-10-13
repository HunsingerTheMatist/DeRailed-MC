# Counts this block in '#room_cells' and goes on up through every block above
#  it a placement can reach into, as far as '#room_cap' blocks
# Run at the bottom middle of a block

scoreboard players add #room_cells dr_temp 1
execute if score #room_cells dr_temp >= #room_cap dr_temp run return 0
execute positioned ~ ~1 ~ if block ~ ~ ~ #derailed:valid_placements run function derailed:item/_room_up
