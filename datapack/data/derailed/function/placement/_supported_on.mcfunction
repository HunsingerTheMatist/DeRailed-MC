# Returns 1 when the block here is a floor whose top is '#base_rel' up a block,
#  in ten-thousandths of a block, fail otherwise
# Run at the floor block

execute unless block ~ ~ ~ #derailed:pile_floor run return fail
function derailed:item/_floor_top
scoreboard players operation #floor_top dr_temp *= $Pixel dr_const
scoreboard players operation #floor_top dr_temp %= $TenThousand dr_const
return run execute if score #floor_top dr_temp = #base_rel dr_temp
