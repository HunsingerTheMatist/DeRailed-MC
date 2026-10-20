
# The model dispatches on stack count, so setting the count picks the model
scoreboard players operation #display_count dr_temp = #items_to_place dr_arg
execute store result entity @n[type=item_display,distance=..0.1,tag=dr_placement] item.count int 1 run scoreboard players operation #display_count dr_temp < $BatchHeight dr_const
