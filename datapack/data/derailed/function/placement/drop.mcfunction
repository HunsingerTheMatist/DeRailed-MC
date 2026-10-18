# Takes this placement away and lets its items fall from where it stood, as
#  thrown piles with no velocity and no thrower, one for each section of it:
#  the bottom one falls at once and each one over it 3 ticks after the one
#  under it
# Run as the placement's interaction entity, at it

scoreboard players operation #curr_item dr_arg = @s dr_item
scoreboard players operation #drop_count dr_temp = @s dr_count
execute store result score #curr_rotation dr_arg run data get entity @s Rotation[0]

# Its cakes go first from every block up to its interaction's top, since what
#  changed under it may have cleared the lowest of them and left the rest
execute store result score #clear_left dr_temp run data get entity @s Pos[1] 10000
scoreboard players operation #clear_left dr_temp %= $TenThousand dr_const
execute store result score #t dr_temp run data get entity @s height 10000
scoreboard players operation #clear_left dr_temp += #t dr_temp
execute align y run function derailed:placement/_clear_cakes

scoreboard players set @s dr_count 0
function derailed:placement/update_placement

scoreboard players operation #curr_item_count dr_arg = #drop_count dr_temp
scoreboard players set #curr_player_id dr_arg 0
scoreboard players set #drop_wait dr_temp 0
function derailed:toss/_drop_section
