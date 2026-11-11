# Opens every chest's lid that is opening a step further, and runs again next
#  tick while any still is
# Ten steps take a lid from shut to open, each a tenth of the way as the
#  vanilla lid goes, which the resource pack draws eased the same way

execute as @e[type=item_display,tag=dr_lid_opening] run function derailed:ender_chest/_lid_step
execute if entity @e[type=item_display,tag=dr_lid_opening] run schedule function derailed:ender_chest/_lid_tick 1t
