# Puts out this burning piece of a train, and for the engine the displays its
#  shulkers ride too, taking away the fire laid over it; its heat goes back to
#  none, so it takes all of it again to catch
# Run as the piece's item display

tag @s remove dr_burning
scoreboard players set @s dr_heat 0
scoreboard players operation #tid dr_temp = @s dr_tid
execute as @e[type=item_display,tag=dr_train_carrier,distance=0..] if score @s dr_tid = #tid dr_temp run tag @s remove dr_burning
execute on passengers if entity @s[type=item_display,tag=dr_fire] run kill @s
execute at @s run playsound minecraft:block.fire.extinguish block @a ~ ~1 ~ 1
execute at @s run particle minecraft:cloud ~ ~1.6 ~ 0.6 0.4 0.6 0.02 20
