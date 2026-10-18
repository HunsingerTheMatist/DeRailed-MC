
# Lays barriers over the block the front of the train has just passed all of,
#  which the front trail stands on, running the way its rail does, and none
#  over a curve, the middle of a corner the train only cuts across; then moves
#  the trail onto the block it is on now
# A straight rail or a tile's powered rail is an iron trapdoor not powered, a
#  curve one powered, and the rail runs the way the front left its block: the
#  trail a block east or west of the front now, or north or south
# Positioned at the middle of the block the front of the train is on

execute positioned ~1 ~ ~ if entity @n[type=marker,tag=dr_trail_front,distance=..0.5] at @n[type=marker,tag=dr_trail_front,distance=0..] if block ~ ~ ~ iron_trapdoor[powered=false] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[east=true,west=true] replace air strict
execute positioned ~-1 ~ ~ if entity @n[type=marker,tag=dr_trail_front,distance=..0.5] at @n[type=marker,tag=dr_trail_front,distance=0..] if block ~ ~ ~ iron_trapdoor[powered=false] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[east=true,west=true] replace air strict
execute positioned ~ ~ ~1 if entity @n[type=marker,tag=dr_trail_front,distance=..0.5] at @n[type=marker,tag=dr_trail_front,distance=0..] if block ~ ~ ~ iron_trapdoor[powered=false] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[north=true,south=true] replace air strict
execute positioned ~ ~ ~-1 if entity @n[type=marker,tag=dr_trail_front,distance=..0.5] at @n[type=marker,tag=dr_trail_front,distance=0..] if block ~ ~ ~ iron_trapdoor[powered=false] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[north=true,south=true] replace air strict
tp @n[type=marker,tag=dr_trail_front,distance=0..] ~ ~ ~
