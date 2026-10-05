
# Lays barriers over the block the walking marker has just passed all of, which
#  the lay trail stands on, running the way its rail does, unless it is the
#  block the walk set off from, which the train only covers part of, and none
#  over a curve, the middle of a corner the train only cuts across; then moves
#  the trail onto the block it is on now
# Positioned at the middle of the block the walking marker is on

execute as @n[type=marker,tag=dr_trail_lay,tag=!dr_trail_first,distance=0..] at @s if block ~ ~ ~ #minecraft:rails[shape=east_west] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[east=true,west=true] replace air strict
execute as @n[type=marker,tag=dr_trail_lay,tag=!dr_trail_first,distance=0..] at @s if block ~ ~ ~ #minecraft:rails[shape=north_south] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[north=true,south=true] replace air strict
tag @n[type=marker,tag=dr_trail_lay,distance=0..] remove dr_trail_first
tp @n[type=marker,tag=dr_trail_lay,distance=0..] ~ ~ ~
