
# Takes this spot unless a seed is within $(r), counting the section before's as
#  well so the spacing carries over the boundary, and the first section's void
#  starts and the points its start station's ground grows from as seeds too

$execute if entity @n[type=marker,tag=dr_prev_seed,distance=..$(r)] run return fail
$execute if entity @n[type=marker,tag=dr_void_mid,distance=..$(r)] run return fail
$execute if entity @n[type=marker,tag=dr_start_mid,distance=..$(r)] run return fail
$execute unless entity @n[type=marker,tag=dr_seed,distance=..$(r)] run function derailed:dev/gen/_spawn
