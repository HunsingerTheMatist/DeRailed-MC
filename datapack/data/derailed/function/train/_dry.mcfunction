# Sets this water wagon, which has used all its water, and its team's engine on
#  fire
# Run as the water wagon's item display

function derailed:train/ignite
scoreboard players operation #team dr_temp = @s dr_team
execute as @e[type=item_display,tag=dr_train_engine,distance=0..] if score @s dr_team = #team dr_temp run function derailed:train/ignite
