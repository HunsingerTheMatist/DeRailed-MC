# Sets this piece of a train on fire, tagged 'dr_burning', and for the engine
#  the displays its shulkers ride too, with its fire laid over it; an
#  engine catching fire kills every survival player in three boxes along it,
#  each a shulker's box a block bigger each way, 4.5 across and 4.5 tall, round
#  each shulker and round its middle, which follow it round a curve
# A selector's box reaches a block further than its dx, dy and dz
# Run as the piece's item display

execute if entity @s[tag=dr_burning] run return 0
tag @s add dr_burning
scoreboard players operation #tid dr_temp = @s dr_tid
execute as @e[type=item_display,tag=dr_train_carrier,distance=0..] if score @s dr_tid = #tid dr_temp run tag @s add dr_burning
execute at @s run function derailed:train/_fire_on
execute at @s run playsound minecraft:item.firecharge.use block @a ~ ~1 ~ 1 0.8
execute if entity @s[tag=dr_train_engine] at @s positioned ~-2.25 ~-0.7 ~-2.25 run kill @a[gamemode=survival,dx=3.5,dy=3.5,dz=3.5]
execute if entity @s[tag=dr_train_engine] at @s at @n[type=item_display,tag=dr_train_carrier_a,distance=..3] positioned ~-2.25 ~-0.7 ~-2.25 run kill @a[gamemode=survival,dx=3.5,dy=3.5,dz=3.5]
execute if entity @s[tag=dr_train_engine] at @s at @n[type=item_display,tag=dr_train_carrier_b,distance=..3] positioned ~-2.25 ~-0.7 ~-2.25 run kill @a[gamemode=survival,dx=3.5,dy=3.5,dz=3.5]
