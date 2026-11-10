
# Covers this tile unless it is the preview's, then the next tile south, as
#  far as the last row
# A tile a carried region took is still the section's own where the section
#  changed it: a river drawn over it, or a cut or a lake that took it, which
#  leave their region on the layer 13 above
# Positioned on the tile, on the layer the regions grow on

scoreboard players set #pv_keep dr_var 0
execute if block ~ ~ ~ #derailed:gen_is_kind unless block ~ ~15 ~ light_blue_concrete if block ~ ~13 ~ air run scoreboard players set #pv_keep dr_var 1
execute if score #pv_c dr_var matches ..1 if block ~ ~ ~ bedrock run scoreboard players set #pv_keep dr_var 1
execute if score #pv_keep dr_var matches 0 if block ~ ~16 ~ air run setblock ~ ~16 ~ black_concrete strict

scoreboard players add #pv_r dr_var 1
execute if score #pv_r dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_preview_tile
