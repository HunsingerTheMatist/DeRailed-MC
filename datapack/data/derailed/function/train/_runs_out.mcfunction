# Returns 1 where the point '#ahead' further along the track than this axle,
#  in thousandths of a block and shorter than any tile, would be past the end
#  of its team's path after the axle's next move, fail otherwise
# Run as the axle's marker

scoreboard players operation #t dr_temp = @s dr_ad
scoreboard players operation #t dr_temp += $TrainSpeed dr_config
scoreboard players operation #t dr_temp += #ahead dr_arg
execute if score #t dr_temp < @s dr_alen run return fail

scoreboard players operation #t dr_temp = @s dr_ai
execute store result storage derailed:train arg.i int 1 run scoreboard players add #t dr_temp 1
execute store result storage derailed:train arg.team int 1 run scoreboard players get @s dr_team
execute store result score #more dr_temp run function derailed:train/_has_tile with storage derailed:train arg
execute if score #more dr_temp matches 1 run return fail
return 1
