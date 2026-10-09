
# Adds this tile's glyph to the row, by whether it is the 26th, cut to its
#  first three pixels, its row, its kind and a variant taken at random; kinds
#  are 0 ground, 1 tree, 2 iron, 3 rock, 4 lake, 5 river, and 6 and 7 the
#  western and eastern tiles of the station's building; then the tile east of
#  it, through the 26th
# Positioned on the tile

scoreboard players set #hud_k dr_temp 0
execute if block ~ ~ ~ brown_concrete run scoreboard players set #hud_k dr_temp 1
execute if block ~ ~ ~ light_gray_concrete run scoreboard players set #hud_k dr_temp 2
execute if block ~ ~ ~ gray_concrete run scoreboard players set #hud_k dr_temp 3
execute if block ~ ~ ~ blue_concrete run scoreboard players set #hud_k dr_temp 4
execute if block ~ ~ ~ light_blue_concrete run scoreboard players set #hud_k dr_temp 5
execute if block ~ ~-15 ~ obsidian run scoreboard players set #hud_k dr_temp 6
execute if block ~ ~-15 ~ obsidian if block ~-1 ~-15 ~ obsidian run scoreboard players set #hud_k dr_temp 7

scoreboard players operation #hud_i dr_temp = #hud_r dr_temp
execute if score #hud_c dr_temp matches 25 run scoreboard players add #hud_i dr_temp 16
scoreboard players operation #hud_i dr_temp *= $HudKinds dr_const
scoreboard players operation #hud_i dr_temp += #hud_k dr_temp
scoreboard players operation #hud_i dr_temp *= $HudVariants dr_const
execute store result score #hud_v dr_temp run random value 0..999999 derailed:hud_tiles
scoreboard players operation #hud_v dr_temp %= $HudVariants dr_const
execute store result storage derailed:hud a.i int 1 run scoreboard players operation #hud_i dr_temp += #hud_v dr_temp
function derailed:dev/hud/_board_tile with storage derailed:hud a

scoreboard players add #hud_c dr_temp 1
execute if score #hud_c dr_temp matches ..25 positioned ~1 ~ ~ run function derailed:dev/hud/_board_col
