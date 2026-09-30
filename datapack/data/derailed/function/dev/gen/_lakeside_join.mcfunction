
# Makes this river tile part of the lake beside it: water on the finished layer
#  and the kinds layer, blue glass over it where nothing else is marked there,
#  and the lake's region two below, where a cut tile keeps the region it took
# Run as the tile's marker, on the finished layer

setblock ~ ~ ~ blue_concrete strict
setblock ~ ~-10 ~ blue_concrete strict
fill ~ ~1 ~ ~ ~1 ~ blue_stained_glass replace air strict
scoreboard players add #gen_lakeside dr_var 1

# The lake's region is the one a cut gave its tile, where it has one, and
#  otherwise the one it grew as
execute if block ~1 ~ ~ blue_concrete if block ~1 ~-2 ~ air run return run clone ~1 ~-15 ~ ~1 ~-15 ~ ~ ~-2 ~ strict
execute if block ~1 ~ ~ blue_concrete run return run clone ~1 ~-2 ~ ~1 ~-2 ~ ~ ~-2 ~ strict
execute if block ~-1 ~ ~ blue_concrete if block ~-1 ~-2 ~ air run return run clone ~-1 ~-15 ~ ~-1 ~-15 ~ ~ ~-2 ~ strict
execute if block ~-1 ~ ~ blue_concrete run return run clone ~-1 ~-2 ~ ~-1 ~-2 ~ ~ ~-2 ~ strict
execute if block ~ ~ ~1 blue_concrete if block ~ ~-2 ~1 air run return run clone ~ ~-15 ~1 ~ ~-15 ~1 ~ ~-2 ~ strict
execute if block ~ ~ ~1 blue_concrete run return run clone ~ ~-2 ~1 ~ ~-2 ~1 ~ ~-2 ~ strict
execute if block ~ ~ ~-1 blue_concrete if block ~ ~-2 ~-1 air run return run clone ~ ~-15 ~-1 ~ ~-15 ~-1 ~ ~-2 ~ strict
execute if block ~ ~ ~-1 blue_concrete run clone ~ ~-2 ~-1 ~ ~-2 ~-1 ~ ~-2 ~ strict
