# Sets '#room' to how high the placement here can reach, as 'item/_room' does,
#  looking as high as '#want_count' of #curr_item would reach
# Run at the placement's interaction entity

execute store result score #base_rel dr_temp run data get entity @n[type=interaction,tag=dr_placement,distance=..0.01] Pos[1] 10000
scoreboard players operation #base_rel dr_temp %= $TenThousand dr_const
execute align y run function derailed:item/_room
