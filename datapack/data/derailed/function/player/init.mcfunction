# Assign a player id and starting items. Run as the player
#
# The id is baked into the items this player is given, so the markers
#  they spawn identify their owner. Ids need only be unique among players
#  present at once

scoreboard players add $NextPid dr_var 1
scoreboard players operation @s dr_player_id = $NextPid dr_var

scoreboard players set @s dr_item 0
scoreboard players set @s dr_count 0

# Starting wood (temp)
scoreboard players operation #curr_item dr_arg = $Wood dr_const
scoreboard players set #give_count dr_arg 1
function derailed:item/give_item
