# Opens the ender chest the player right-clicked: its lid swings up over half a
#  second, with the ender chest's own sound, and stays open; one already open
#  takes no notice
# Run as the player

data remove entity @n[type=interaction,distance=..10,tag=dr_ender_chest,tag=dr_current] interaction
execute at @n[type=interaction,distance=..10,tag=dr_ender_chest,tag=dr_current] as @n[type=item_display,tag=dr_ender_chest_lid,tag=!dr_lid_open,distance=..1] at @s run function derailed:ender_chest/_open
