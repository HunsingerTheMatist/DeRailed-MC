# Starts this chest's lid opening, a step a tick from the next ('_lid_tick')
# Run as the chest's item display, at it

tag @s add dr_lid_open
tag @s add dr_lid_opening
scoreboard players set @s dr_lid 0
playsound minecraft:block.ender_chest.open block @a ~ ~ ~ 0.5 0.95
schedule function derailed:ender_chest/_lid_tick 1t
