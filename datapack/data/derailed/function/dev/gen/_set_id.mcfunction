
# Places the block for the region held in '#gen_id'
# Four ladders of seven or eight rather than one of thirty one: a region is as
#  likely to be any number as any other, so the one ladder was thirteen tests deep
#  on average, where two range tests and a short one come to about six

execute if score #gen_id dr_var matches ..7 run return run function derailed:dev/gen/_set_id_a
execute if score #gen_id dr_var matches ..15 run return run function derailed:dev/gen/_set_id_b
execute if score #gen_id dr_var matches ..23 run return run function derailed:dev/gen/_set_id_c
function derailed:dev/gen/_set_id_d
