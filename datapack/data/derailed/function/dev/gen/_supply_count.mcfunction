
# Counts what is within reach on the finished terrain, tile by tile, then adds
#  it up cheapest first: the free tiles, then every reached region of wood or
#  iron by how much water lies on the way to it, each taken only while its
#  kind is still short and its bridges charged as it is taken
# What the routes need is worked out again first from the water now under them,
#  since a repaint may have turned a region they cross into water or out of it
# Positioned at the section's corner, with the routes kept three above

function derailed:dev/gen/_supply_wet
function derailed:dev/gen/_supply_base
execute as @e[type=marker,tag=dr_seed,distance=0..] run scoreboard players set @s dr_size 0
scoreboard players set #sup_wood_free dr_var 0
scoreboard players set #sup_iron_free dr_var 0
data modify storage derailed:gen e.f set value "_supply_tile_at"
function derailed:dev/gen/_each

fill ~ ~5 ~ ~31 ~5 ~15 air replace cyan_stained_glass strict
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_used
scoreboard players operation #sup_wood dr_var = #sup_wood_free dr_var
scoreboard players operation #sup_iron dr_var = #sup_iron_free dr_var
scoreboard players set #sup_bridges dr_var 0

# Every piece the players can get to has the bridges on the way to it charged
#  before any region is taken, and one the flood never reached is dropped
scoreboard players set #piece_lost dr_var 0
tag @e[type=marker,tag=dr_piece,distance=0..] remove dr_dropped
execute as @e[type=marker,tag=dr_piece,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_piece_reach

scoreboard players set #sup_k dr_var 0
function derailed:dev/gen/_supply_round

# A region passed over because its kind had enough can be wanted after all,
#  where the bridges to a region taken later raised what that kind needs, so
#  the regions not yet taken are gone through again until none is wanted
function derailed:dev/gen/_supply_again
