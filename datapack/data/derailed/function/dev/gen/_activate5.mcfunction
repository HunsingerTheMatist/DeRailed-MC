
# Hands this tile's region to the four neighbours a straight step away
# Unclaimed ground is the fill the section started as, so growth stops at the
#  section edge on its own
# The region arrived on the marker when the tile was claimed, so neither this pass
#  nor the diagonal one has to read the tile

scoreboard players operation #gen_id dr_var = @s dr_id

execute positioned ~1 ~ ~ if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim5 with storage derailed:gen a5
execute positioned ~-1 ~ ~ if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim5 with storage derailed:gen a5
execute positioned ~ ~ ~1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim5 with storage derailed:gen a5
execute positioned ~ ~ ~-1 if block ~ ~ ~ black_concrete run function derailed:dev/gen/_claim5 with storage derailed:gen a5
