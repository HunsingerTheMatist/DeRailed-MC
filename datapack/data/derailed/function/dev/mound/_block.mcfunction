
# Builds the column $(x) $(z) into the tile: its height the corners weighed
#  $(a) northwest, $(b) northeast, $(c) southwest and $(d) southeast, out of
#  thirty-six, a little either way on its own and with the whole tile, a spike
#  higher where the tile's spiking patch is one it stands in, $(s0) to $(s3)
#  saying which, kept between '#msmin' and '#mmax' pixels, then made of whole
#  blocks with whatever of the kind's tops tops them nearest what is left over
# Positioned at the tile's northwestern block

$scoreboard players set #mwa dr_var $(a)
$scoreboard players set #mwb dr_var $(b)
$scoreboard players set #mwc dr_var $(c)
$scoreboard players set #mwd dr_var $(d)
scoreboard players operation #mH dr_var = #h00 dr_var
scoreboard players operation #mH dr_var *= #mwa dr_var
scoreboard players operation #mt dr_var = #h10 dr_var
scoreboard players operation #mt dr_var *= #mwb dr_var
scoreboard players operation #mH dr_var += #mt dr_var
scoreboard players operation #mt dr_var = #h01 dr_var
scoreboard players operation #mt dr_var *= #mwc dr_var
scoreboard players operation #mH dr_var += #mt dr_var
scoreboard players operation #mt dr_var = #h11 dr_var
scoreboard players operation #mt dr_var *= #mwd dr_var
scoreboard players operation #mH dr_var += #mt dr_var
scoreboard players operation #mH dr_var /= #m36 dr_var

data modify storage derailed:mound r.v set from storage derailed:mound cfg.jit
function derailed:dev/mound/_nudge with storage derailed:mound r
scoreboard players operation #mH dr_var += #mj dr_var
scoreboard players operation #mH dr_var += #mtj dr_var
scoreboard players set #mhit dr_var 0
$execute if score #msq dr_var matches 0 run scoreboard players set #mhit dr_var $(s0)
$execute if score #msq dr_var matches 1 run scoreboard players set #mhit dr_var $(s1)
$execute if score #msq dr_var matches 2 run scoreboard players set #mhit dr_var $(s2)
$execute if score #msq dr_var matches 3 run scoreboard players set #mhit dr_var $(s3)
execute if score #mhit dr_var matches 1 run scoreboard players operation #mH dr_var += #mspkpx dr_var
execute if score #mH dr_var < #msmin dr_var run scoreboard players operation #mH dr_var = #msmin dr_var
execute if score #mH dr_var > #mmax dr_var run scoreboard players operation #mH dr_var = #mmax dr_var

# How many whole blocks, and what tops them: '#mtopi' the tall top block in
#  place of the top whole block and '#mcap' the slab over them, each -1 for
#  none
scoreboard players operation #mk dr_var = #mH dr_var
scoreboard players operation #mk dr_var /= #m16 dr_var
scoreboard players operation #mH dr_var %= #m16 dr_var
scoreboard players set #mtopi dr_var -1
scoreboard players set #mcap dr_var -1
function derailed:dev/mound/_quant with storage derailed:mound cfg

execute store result storage derailed:mound c.k int 1 run scoreboard players get #mk dr_var
execute store result storage derailed:mound c.k1 int 1 run scoreboard players remove #mk dr_var 1
scoreboard players add #mk dr_var 1
data modify storage derailed:mound c.full set from storage derailed:mound cfg.full
data modify storage derailed:mound c.top set from storage derailed:mound cfg.full
execute store result storage derailed:mound c.t int 1 run scoreboard players get #mtopi dr_var
execute if score #mtopi dr_var matches 0.. run function derailed:dev/mound/_top with storage derailed:mound c
execute store result storage derailed:mound c.i int 1 run scoreboard players get #mcap dr_var
execute if score #mcap dr_var matches 0.. run function derailed:dev/mound/_cap with storage derailed:mound c
$execute positioned ~$(x) ~ ~$(z) run function derailed:dev/mound/_column with storage derailed:mound c
