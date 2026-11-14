# Starts this chest's lid opening, a step a tick from the next ('_lid_tick'),
#  and stops it sparkling, its 'dr_chest_spark' marker being taken away
# Run as the chest's item display, at it, in the middle of the chest's block

tag @s add dr_lid_open
tag @s add dr_lid_opening
scoreboard players set @s dr_lid 0
playsound minecraft:block.ender_chest.open block @a ~ ~ ~ 0.5 0.95
kill @e[type=marker,tag=dr_chest_spark,distance=..0.5]
schedule function derailed:ender_chest/_lid_tick 1t
