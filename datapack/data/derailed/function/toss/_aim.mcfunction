# Takes the aim it runs facing, as the step a block along it makes, into '#ax',
#  '#ay' and '#az', and the height it starts at into '#ay0', in ten-thousandths
#  of a block, and removes this new marker
# Run as the new marker, facing the aim

execute store result score #ax dr_temp run data get entity @s Pos[0] 10000
execute store result score #ay0 dr_temp store result score #ay dr_temp run data get entity @s Pos[1] 10000
execute store result score #az dr_temp run data get entity @s Pos[2] 10000
tp @s ^ ^ ^1
execute store result score #t dr_temp run data get entity @s Pos[0] 10000
scoreboard players operation #t dr_temp -= #ax dr_temp
scoreboard players operation #ax dr_temp = #t dr_temp
execute store result score #t dr_temp run data get entity @s Pos[1] 10000
scoreboard players operation #t dr_temp -= #ay dr_temp
scoreboard players operation #ay dr_temp = #t dr_temp
execute store result score #t dr_temp run data get entity @s Pos[2] 10000
scoreboard players operation #t dr_temp -= #az dr_temp
scoreboard players operation #az dr_temp = #t dr_temp
kill @s
