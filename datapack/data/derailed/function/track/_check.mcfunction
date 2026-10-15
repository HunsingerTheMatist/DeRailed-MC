# Returns 1 when every block a rail laid on the way on takes is open ground,
#  fail otherwise: the new tile's edge, middle and far edge, two to four blocks
#  ahead, and the end's own edge a block ahead where its rail turns
# Run at the middle of the end of the track's middle block, facing the way on

execute positioned ^ ^ ^2 unless function derailed:track/_open run return fail
execute positioned ^ ^ ^3 unless function derailed:track/_open run return fail
execute positioned ^ ^ ^4 unless function derailed:track/_open run return fail
execute if score #curve dr_temp matches 1 positioned ^ ^ ^1 unless function derailed:track/_open run return fail
return 1
