
# Lays barriers over the block the front of the train has just passed all of,
#  which the front trail stands on, running the way its rail does, and none
#  over a curve, the middle of a corner the train only cuts across; then moves
#  the trail onto the block it is on now
# Positioned at the middle of the block the front of the train is on

execute at @n[type=marker,tag=dr_trail_front,distance=0..] if block ~ ~ ~ #minecraft:rails[shape=east_west] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[east=true,west=true] replace air strict
execute at @n[type=marker,tag=dr_trail_front,distance=0..] if block ~ ~ ~ #minecraft:rails[shape=north_south] positioned ~ ~0.8 ~ run fill ~ ~ ~ ~ ~1 ~ pink_stained_glass_pane[north=true,south=true] replace air strict
tp @n[type=marker,tag=dr_trail_front,distance=0..] ~ ~ ~
