# A vanilla item entity that appeared this tick. Run as the item entity
#
# Item entities exist only for the tick between a player dropping one and this
#  turning it into a placement, so anything that cannot be traced back to a
#  carrying player is destroyed rather than placed

tag @s add dr_processed

# An item with no thrower should not be possible, so it is left in the world to
#  be found and inspected rather than cleaned up
execute unless data entity @s Thrower run return run tellraw @a [{text:"[item] ",color:"gold"},{text:"unthrown item - left in world",color:"red"}]

tag @a[distance=..10] remove dr_current
$tag @p[distance=..10,nbt={UUID:$(Thrower)}] add dr_current

# The thrower has to be here, and the record has to say they were carrying
execute unless entity @p[distance=..10,tag=dr_current] run return run kill @s
execute unless score @p[distance=..10,tag=dr_current] dr_count matches 1.. run return run kill @s

scoreboard players operation #curr_player_id dr_arg = @p[distance=..10,tag=dr_current] dr_player_id
scoreboard players operation #curr_item dr_arg = @p[distance=..10,tag=dr_current] dr_item
execute store result score #curr_rotation dr_arg run data get entity @p[distance=..10,tag=dr_current] Rotation[0] 1

# Get count from item
execute store result score #curr_item_count dr_arg run data get entity @s Item.count
scoreboard players operation #curr_item_count dr_arg < @p[distance=..10,tag=dr_current] dr_count

scoreboard players set #swap_allowed dr_arg 0
execute as @p[distance=..10,tag=dr_current] at @s align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/try_place
# Potential bug: if the player jumps then the placement logic might not work. Need to test

kill @s
