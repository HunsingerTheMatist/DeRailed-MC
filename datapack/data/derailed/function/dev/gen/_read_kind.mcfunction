
# Reads the kind back out of the block on this tile
# These five blocks are the ones 'kinds' holds in 'dev/gen/load', in that order,
#  and recolouring a kind means changing both
# The terrain is kept in the world rather than on the marker, so a marker never
#  has to be looked up or given a score

# Each line returns on a match, and the kinds are ordered by how common they are,
#  so the ladder usually stops after two or three
execute if block ~ ~ ~ lime_concrete run return run scoreboard players set #gen_kind dr_var 0
execute if block ~ ~ ~ gray_concrete run return run scoreboard players set #gen_kind dr_var 4
execute if block ~ ~ ~ brown_concrete run return run scoreboard players set #gen_kind dr_var 1
execute if block ~ ~ ~ light_gray_concrete run return run scoreboard players set #gen_kind dr_var 2
execute if block ~ ~ ~ blue_concrete run return run scoreboard players set #gen_kind dr_var 3
