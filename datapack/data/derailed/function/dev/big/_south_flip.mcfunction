
# Has the stretch this tile starts flow the other way: this tile the way
#  opposite to the way it flowed, out of the end the river came in by, and each
#  tile after it toward the one before it
# Run as the marker of the stretch's first tile, at it

scoreboard players operation #s_n dr_temp = @s dr_bdir
scoreboard players add #s_n dr_temp 2
scoreboard players operation #s_n dr_temp %= $Four dr_const
function derailed:dev/big/_south_set
function derailed:dev/big/_south_flip_walk
