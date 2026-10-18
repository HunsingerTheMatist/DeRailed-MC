# Returns 1 when this placement still stands on a floor that holds it where it
#  is, the floor 'item/place_on_floor' would have put it on, fail otherwise
# It stands on the block it is in where it stands part way up that block, a
#  slab, and otherwise on the block under it, a whole block or the iron's tall
#  top block
# Run as the placement's interaction entity, at it

execute store result score #base_rel dr_temp run data get entity @s Pos[1] 10000
scoreboard players operation #base_rel dr_temp %= $TenThousand dr_const
execute if score #base_rel dr_temp matches 5000.. align y run return run function derailed:placement/_supported_on
execute align y positioned ~ ~-1 ~ run return run function derailed:placement/_supported_on
