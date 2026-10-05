
# Sets this piece between its two axles, which are tagged 'dr_axle_here' while
#  it does, and its parts round it
# Run as the piece's item display

scoreboard players operation #tid dr_temp = @s dr_tid
execute as @e[type=marker,tag=dr_axle,distance=0..] if score @s dr_tid = #tid dr_temp run tag @s add dr_axle_here
execute if entity @s[tag=dr_train_engine] run function derailed:train/_engine
execute if entity @s[tag=dr_train_supply] run function derailed:train/_supply
execute if entity @s[tag=dr_train_water] run function derailed:train/_water
execute if entity @s[tag=dr_train_crafting] run function derailed:train/_crafting
tag @e[type=marker,tag=dr_axle_here,distance=0..] remove dr_axle_here
