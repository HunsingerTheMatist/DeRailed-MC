# Readies this new thrown display to carry #curr_item_count of #curr_item: the
#  look of them, its box the size of the pile they make, the way it faces, and
#  what it carries, who threw it and how long it has flown
# Run as the new display
#
# Args: #curr_item, #curr_item_count, #curr_player_id, #curr_rotation

function derailed:toss/_look

function derailed:toss/_box_height
execute on passengers store result entity @s height float 0.0001 run scoreboard players get #toss_h dr_temp

# It faces the way the placement it makes will, snapped to 90 degree steps as
#  'item/place_new' snaps it
scoreboard players operation #rotation dr_temp = #curr_rotation dr_arg
scoreboard players add #rotation dr_temp 405
scoreboard players operation #rotation dr_temp /= $RotationStep dr_const
scoreboard players operation #rotation dr_temp *= $RotationStep dr_const
execute store result entity @s Rotation[0] float 1 run scoreboard players remove #rotation dr_temp 360

# Wood standing straight is tinted down as a placement's display is, since its
#  ends along z catch more light
scoreboard players operation #use_darker_tint dr_temp = #rotation dr_temp
scoreboard players operation #use_darker_tint dr_temp %= $HalfTurn dr_const
execute if score #curr_item dr_arg = $Wood dr_const if score #use_darker_tint dr_temp matches 0 run \
    data modify entity @s item.components."minecraft:custom_model_data" set value {strings:["turned"]}

scoreboard players operation @s dr_item = #curr_item dr_arg
scoreboard players operation @s dr_count = #curr_item_count dr_arg
scoreboard players operation @s dr_player_id = #curr_player_id dr_arg
scoreboard players set @s dr_toss_age 0
tag @s remove dr_toss_new
