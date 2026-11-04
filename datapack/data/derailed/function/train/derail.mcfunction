# Derails this train, which has run out of track: it stops where it is for
#  good, its engine tagged 'dr_derailed' and every axle of it 'dr_stopped'
# Run as the train's engine

tag @s add dr_derailed
scoreboard players operation #team dr_temp = @s dr_team
execute as @e[type=marker,tag=dr_axle,distance=0..] if score @s dr_team = #team dr_temp run tag @s add dr_stopped
