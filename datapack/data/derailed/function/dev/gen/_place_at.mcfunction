
# Takes this spot unless a seed is within $(r), counting the section before's as
#  well so the spacing carries over the boundary

$execute if entity @n[type=marker,tag=dr_prev_seed,distance=..$(r)] run return fail
$execute unless entity @n[type=marker,tag=dr_seed,distance=..$(r)] run function derailed:dev/gen/_spawn
