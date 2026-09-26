
# Counts this tile as supply if it is wood or iron that the flood got to: onto
#  its region's seed where the region is one of this section's own drawn as
#  that kind, and otherwise as a free tile, which is what a tile carried over
#  the seam or cut into a resource is
# Positioned on the tile, with the flood's marks two above and the regions as
#  they grew fifteen below

execute unless block ~ ~2 ~ #derailed:flood_visited run return 0
scoreboard players set #sup_kind dr_var 0
execute if block ~ ~ ~ brown_concrete run scoreboard players set #sup_kind dr_var 1
execute if block ~ ~ ~ light_gray_concrete run scoreboard players set #sup_kind dr_var 2
execute if score #sup_kind dr_var matches 0 run return 0

scoreboard players set #gen_id dr_var -1
execute positioned ~ ~-15 ~ run function derailed:dev/gen/_read_id
scoreboard players set #sup_owned dr_var 0
execute as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var if score @s dr_kind = #sup_kind dr_var run function derailed:dev/gen/_supply_own
execute if score #sup_owned dr_var matches 1 run return 0

execute if score #sup_kind dr_var matches 1 run scoreboard players add #sup_wood_free dr_var 1
execute if score #sup_kind dr_var matches 2 run scoreboard players add #sup_iron_free dr_var 1
