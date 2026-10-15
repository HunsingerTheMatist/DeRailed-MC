# Plans this placement's move aside, whole, as dropping its items here would,
#  noting in '#shift_failed' where nothing round here takes it
# The planning is done by a throwaway marker, since placing takes the items off
#  whoever runs it
# Run as the placement's interaction entity, at the bottom middle of the block
#  it stands in

execute if score #shift_failed dr_temp matches 1 run return 0
scoreboard players operation #curr_item dr_arg = @s dr_item
scoreboard players operation #curr_item_count dr_arg = @s dr_count
execute store result score #curr_rotation dr_arg run data get entity @s Rotation[0]
execute summon marker unless function derailed:track/_shift_search run scoreboard players set #shift_failed dr_temp 1
