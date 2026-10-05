
# Stands this axle on a corner's quarter turn: half a tile from the tile's
#  corner inside the turn, which lies back the way in and on the way out,
#  facing from the way out reversed toward the way in as far as it has turned
# A facing of 0 is south and 90 west, so a way's facing is its number plus two
#  quarters round, and the way out reversed is its number of quarters
# Run as the axle's marker, with the ways in '#dix', '#diz', '#dox' and '#doz'

scoreboard players operation #x dr_temp = #dox dr_temp
scoreboard players operation #x dr_temp -= #dix dr_temp
scoreboard players operation #x dr_temp *= $HalfTile dr_const
execute store result entity @s Pos[0] double 0.001 run scoreboard players operation #x dr_temp += @s dr_acx
scoreboard players operation #z dr_temp = #doz dr_temp
scoreboard players operation #z dr_temp -= #diz dr_temp
scoreboard players operation #z dr_temp *= $HalfTile dr_const
execute store result entity @s Pos[2] double 0.001 run scoreboard players operation #z dr_temp += @s dr_acz

# Which way round it turns: from the way out reversed to the way in is a
#  quarter either way, turning the facing up or down
scoreboard players operation #f0 dr_temp = @s dr_adout
scoreboard players operation #f0 dr_temp *= $RotationStep dr_const
scoreboard players operation #f1 dr_temp = @s dr_adin
scoreboard players add #f1 dr_temp 2
scoreboard players operation #f1 dr_temp %= $Four dr_const
scoreboard players operation #f1 dr_temp *= $RotationStep dr_const
scoreboard players operation #f1 dr_temp -= #f0 dr_temp
execute if score #f1 dr_temp matches 181.. run scoreboard players remove #f1 dr_temp 360
execute if score #f1 dr_temp matches ..-181 run scoreboard players add #f1 dr_temp 360

# The facing, in thousandths of a degree, a quarter over the turn's length
scoreboard players operation #t dr_temp = @s dr_ad
scoreboard players operation #t dr_temp *= $QuarterTurn dr_const
scoreboard players operation #t dr_temp /= $CornerTurn dr_const
scoreboard players operation #f0 dr_temp *= $Thousand dr_const
execute if score #f1 dr_temp matches 1.. run scoreboard players operation #f0 dr_temp += #t dr_temp
execute if score #f1 dr_temp matches ..-1 run scoreboard players operation #f0 dr_temp -= #t dr_temp
execute store result entity @s Rotation[0] float 0.001 run scoreboard players get #f0 dr_temp
execute at @s positioned ^ ^ ^1.5 run tp @s ~ ~ ~
