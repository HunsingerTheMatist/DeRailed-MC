
# Hands this tile to a region beside it if it is a stray, one that meets no
#  other tile of its own region along an edge
# The regions are read on the kinds layer, which still holds them, and where
#  the river runs is read off the layer it was cut into, so a tile the river
#  took counts as no one's and the branches the search gave up on stay out of
#  the way
# Positioned on the tile

# River is no one's, and a tile carried over the seam keeps what it was, since
#  it has to match the section before across the boundary
execute if block ~ ~9 ~ magenta_glazed_terracotta run return 0
execute if block ~ ~5 ~ #derailed:gen_is_kind run return 0

# A tile with an edge to another of its own region is where it belongs
execute unless block ~1 ~9 ~ magenta_glazed_terracotta if blocks ~ ~5 ~ ~ ~5 ~ ~1 ~5 ~ all run return 0
execute unless block ~-1 ~9 ~ magenta_glazed_terracotta if blocks ~ ~5 ~ ~ ~5 ~ ~-1 ~5 ~ all run return 0
execute unless block ~ ~9 ~1 magenta_glazed_terracotta if blocks ~ ~5 ~ ~ ~5 ~ ~ ~5 ~1 all run return 0
execute unless block ~ ~9 ~-1 magenta_glazed_terracotta if blocks ~ ~5 ~ ~ ~5 ~ ~ ~5 ~-1 all run return 0

# The wall's rock stays, since a river cutting a thin part of it can leave a
#  stray beside the cut, and handing that on would open the cut two wide; a
#  lake's water stays too, since water beside a river looks as it should
scoreboard players set #gen_id dr_var -1
function derailed:dev/gen/_read_id
scoreboard players set #stray_keep dr_var 0
execute as @e[type=marker,tag=dr_seed,tag=dr_wall,distance=0..] if score @s dr_id = #gen_id dr_var run scoreboard players set #stray_keep dr_var 1
execute as @e[type=marker,tag=dr_seed,tag=dr_lake,distance=0..] if score @s dr_id = #gen_id dr_var run scoreboard players set #stray_keep dr_var 1
execute if score #stray_keep dr_var matches 1 run return 0

# The nearest seed among the regions beside it takes it, and where none of them
#  has a seed here it copies a neighbour instead
execute unless block ~1 ~9 ~ magenta_glazed_terracotta positioned ~1 ~5 ~ run function derailed:dev/gen/_stray_near
execute unless block ~-1 ~9 ~ magenta_glazed_terracotta positioned ~-1 ~5 ~ run function derailed:dev/gen/_stray_near
execute unless block ~ ~9 ~1 magenta_glazed_terracotta positioned ~ ~5 ~1 run function derailed:dev/gen/_stray_near
execute unless block ~ ~9 ~-1 magenta_glazed_terracotta positioned ~ ~5 ~-1 run function derailed:dev/gen/_stray_near
execute if entity @e[type=marker,tag=dr_near,distance=0..] run return run function derailed:dev/gen/_stray_take
function derailed:dev/gen/_stray_copy
