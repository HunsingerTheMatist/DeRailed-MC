
# Works out where the river may go next from this corner while it is heading
#  west, leaving the answer in '#riv_v0' straight on, '#riv_v1' the left turn,
#  '#riv_v2' the right one, '#riv_exit' the side it could leave by and
#  '#riv_join' whether a way on comes up against water already laid
# An edge of the lattice is a region boundary when the two tiles either side of
#  it differ; both being air instead means the edge leaves the section
# Water at the corner a way leads to is the river the section cut first, which
#  the second may end in; a corner back in the section before is not asked,
#  since water there is another section's river

scoreboard players set #riv_exit dr_var -1

scoreboard players set #riv_v0 dr_var 0
execute unless block ~-1 ~5 ~-1 air unless block ~-1 ~5 ~ air unless blocks ~-1 ~5 ~-1 ~-1 ~5 ~-1 ~-1 ~5 ~ all run scoreboard players set #riv_v0 dr_var 1
execute if block ~-1 ~5 ~-1 air if block ~-1 ~5 ~ air run scoreboard players set #riv_exit dr_var 1
execute if score #riv_col dr_var matches 1.. if block ~-1 ~9 ~ magenta_glazed_terracotta run scoreboard players set #riv_join dr_var 1
execute if score #riv_v0 dr_var matches 1 positioned ~-1 ~ ~ if entity @n[type=marker,tag=dr_riv_path,distance=..0.4] run scoreboard players set #riv_v0 dr_var 0

scoreboard players set #riv_v1 dr_var 0
execute unless block ~-1 ~5 ~ air unless block ~ ~5 ~ air unless blocks ~-1 ~5 ~ ~-1 ~5 ~ ~ ~5 ~ all run scoreboard players set #riv_v1 dr_var 1
execute if block ~-1 ~5 ~ air if block ~ ~5 ~ air run scoreboard players set #riv_exit dr_var 0
execute if block ~ ~9 ~1 magenta_glazed_terracotta run scoreboard players set #riv_join dr_var 1
execute if score #riv_v1 dr_var matches 1 positioned ~ ~ ~1 if entity @n[type=marker,tag=dr_riv_path,distance=..0.4] run scoreboard players set #riv_v1 dr_var 0

scoreboard players set #riv_v2 dr_var 0
execute unless block ~-1 ~5 ~-1 air unless block ~ ~5 ~-1 air unless blocks ~-1 ~5 ~-1 ~-1 ~5 ~-1 ~ ~5 ~-1 all run scoreboard players set #riv_v2 dr_var 1
execute if block ~-1 ~5 ~-1 air if block ~ ~5 ~-1 air run scoreboard players set #riv_exit dr_var 2
execute if block ~ ~9 ~-1 magenta_glazed_terracotta run scoreboard players set #riv_join dr_var 1
execute if score #riv_v2 dr_var matches 1 positioned ~ ~ ~-1 if entity @n[type=marker,tag=dr_riv_path,distance=..0.4] run scoreboard players set #riv_v2 dr_var 0

# Bleed off the section before reads as one region however many it was, so
#  there is nothing in it to follow: the line carries straight on through it
#  until it reaches ground the section grew for itself
execute if score #riv_bleed dr_var matches 1 run scoreboard players set #riv_v1 dr_var 0
execute if score #riv_bleed dr_var matches 1 run scoreboard players set #riv_v2 dr_var 0
execute if score #riv_bleed dr_var matches 1 unless block ~-1 ~5 ~-1 air unless block ~-1 ~5 ~ air positioned ~-1 ~ ~ unless entity @n[type=marker,tag=dr_riv_path,distance=..0.4] run scoreboard players set #riv_v0 dr_var 1

# The one way the river may not go is back into the section before, so a step
#  west is shut out of column 0
# Running the seam itself is allowed, wherever a boundary happens to lie along it
execute if score #riv_col dr_var matches ..0 run scoreboard players set #riv_v0 dr_var 0

# Which way each of the three answers points, for whoever picks between them
scoreboard players set #riv_d0 dr_var 1
scoreboard players set #riv_d1 dr_var 0
scoreboard players set #riv_d2 dr_var 2
