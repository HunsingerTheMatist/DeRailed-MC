# Catches the thrown pile whose interaction this player clicked, where their
#  hand is empty or holds the same item with room for all of it; nothing is
#  swapped, so otherwise the catch is refused
# Run as the player

data remove entity @n[type=interaction,distance=..10,tag=dr_toss_box,tag=dr_current] interaction
execute as @n[type=interaction,distance=..10,tag=dr_toss_box,tag=dr_current] on vehicle run tag @s add dr_toss_caught
scoreboard players operation #curr_item dr_arg = @n[type=item_display,tag=dr_toss_caught,distance=..10] dr_item
scoreboard players operation #give_count dr_arg = @n[type=item_display,tag=dr_toss_caught,distance=..10] dr_count

# Room for all of it: an empty hand, or the same item with the two together no
#  more than a hand holds
scoreboard players operation #t dr_temp = @s dr_count
scoreboard players operation #t dr_temp += #give_count dr_arg
scoreboard players set #toss_room dr_temp 0
execute if score @s dr_count matches ..0 run scoreboard players set #toss_room dr_temp 1
execute if score @s dr_item = #curr_item dr_arg if score #t dr_temp <= $HandCap dr_config run scoreboard players set #toss_room dr_temp 1

execute if score #toss_room dr_temp matches 0 run tag @e[type=item_display,tag=dr_toss_caught,distance=..10] remove dr_toss_caught
execute if score #toss_room dr_temp matches 0 run return run function derailed:item/reject

function derailed:item/give_item
execute as @n[type=item_display,tag=dr_toss_caught,distance=..10] run function derailed:toss/_remove
return 1
