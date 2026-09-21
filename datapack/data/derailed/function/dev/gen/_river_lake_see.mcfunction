
# Puts the region on this tile into the draw for the lake
# Positioned on the tile

# The two tiles of the four that the end of the river wets are no use as a lake,
#  and the base still has their regions on it, so they are turned away by what was
#  cut into the copy rather than by what is under them
execute if block ~ ~9 ~ magenta_glazed_terracotta run return fail

# The ladder only writes on a match, so a tile lying off the section has to start
#  from nothing rather than answer as the tile before
scoreboard players set #gen_id dr_var -1
function derailed:dev/gen/_read_id

# Only a region of this section's own may be turned: one carried over the seam
#  keeps the kind it came with, and changing it here would leave it a different
#  kind either side of the boundary
execute unless score #gen_id dr_var matches 0..25 run return fail

# The whole of the draw's storage is laid down fresh rather than the one field
#  written into it, so a macro can only ever read what this call put there
scoreboard players add #lake_n dr_var 1
data modify storage derailed:gen lake set value {}
execute store result storage derailed:gen lake.n int 1 run scoreboard players get #lake_n dr_var
function derailed:dev/gen/_river_lake_roll with storage derailed:gen lake
