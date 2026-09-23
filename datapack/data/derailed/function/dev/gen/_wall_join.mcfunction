
# Puts this seed on the band, with every region on the way to it from where the
#  band was last, and carries on south from it
# Run as the seed, positioned where the band was last, with '#wall_lx' and
#  '#wall_lz' where that is

tag @s add dr_wall
scoreboard players set #wall_went dr_var 1

execute store result score #wall_tx dr_var run data get entity @s Pos[0]
execute store result score #wall_tz dr_var run data get entity @s Pos[2]
function derailed:dev/gen/_wall_line

execute at @s run function derailed:dev/gen/_wall_walk
