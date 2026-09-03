# Take every resource from the player and zero their carried record
# Run as the player
#
# Returns the number of items cleared

scoreboard players operation #cleared dr_temp = @s dr_count
clear @s panda_spawn_egg
scoreboard players set @s dr_resource 0
scoreboard players set @s dr_count 0
return run scoreboard players get #cleared dr_temp
