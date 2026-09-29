
# Throws the section out and lays it again from new seeds, keeping the entry
#  row, the exit row, the station and what the section before left at the
#  seam, then gives it a new round of attempts; and counts it
# Positioned at the section's corner

scoreboard players remove #gen_fresh_left dr_var 1
scoreboard players add #gen_fresh_total dr_var 1
function derailed:dev/gen/_lay_restore

# The seeds go, and whatever stood over them, waited on their growth or noted
#  where they reached the eastern edge; the station's notes stay
kill @e[type=marker,tag=dr_seed,distance=0..]
kill @e[type=armor_stand,tag=dr_seed_mark,dx=31,dy=24,dz=15]
kill @e[type=marker,tag=dr_seam_wait,distance=0..]
kill @e[type=marker,tag=dr_edge,tag=!dr_prefab,dx=31,dy=0,dz=15]

# The section before's notes are read again by the seam
tag @e[type=marker,tag=dr_edge_kept,distance=0..] add dr_edge
tag @e[type=marker,tag=dr_edge_kept,distance=0..] remove dr_edge_kept

# The layer the regions grow on starts bare but for the station, and the marker
#  layer bare, the station's rails being drawn again by every attempt
fill ~ ~ ~ ~31 ~ ~15 air strict
fill ~ ~16 ~ ~31 ~16 ~15 air strict
execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_station_stamp with storage derailed:gen r

scoreboard players set #gen_fresh dr_var 1
function derailed:dev/gen/_lay_regions
scoreboard players set #gen_fresh dr_var 0

scoreboard players operation #gen_attempts dr_var = #gen_attempt_count dr_var
scoreboard players set #gen_second_misses dr_var 0
function derailed:dev/gen/_build_attempt
