
# Moves every axle on along the track, then keeps barriers over the rails from
#  each train's front end to its back end, sets each piece between its two
#  axles with its parts round it, moves any player the shulkers moved into back
#  out of them, then keeps the track the train runs on stretching past its
#  front and trimmed behind its back
# Run in the game's dimension

execute unless entity @e[type=item_display,tag=dr_train_piece,distance=0..] run return 0
execute as @e[type=marker,tag=dr_axle,distance=0..] run function derailed:train/_axle

# The front end lays barriers over a block once it has passed all of it, and
#  the back end clears them from a block as soon as it comes onto it, so they
#  stand only on blocks inside the train
execute as @e[type=marker,tag=dr_reach_front,distance=0..] at @s align xz positioned ~0.5 ~ ~0.5 unless entity @e[type=marker,tag=dr_trail_front,distance=..0.1] run function derailed:train/_reach_front_moved
execute as @e[type=marker,tag=dr_reach_back,distance=0..] at @s align xz positioned ~0.5 ~ ~0.5 unless entity @e[type=marker,tag=dr_trail_back,distance=..0.1] run function derailed:train/_reach_back_moved

execute as @e[type=item_display,tag=dr_train_piece,distance=0..] run function derailed:train/_piece
execute as @a[distance=0..] at @s if entity @e[type=item_display,tag=dr_train_box,distance=..3] run function derailed:train/_push
function derailed:train/_path_keep
