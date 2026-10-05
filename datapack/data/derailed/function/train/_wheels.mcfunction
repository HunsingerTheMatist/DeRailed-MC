
# Turns this piece's wheels the way the piece faces, from 'rot', and rolls them
#  all together by how far it has gone, at the rate the big wheels roll, 0.45
#  from the middle to the rim: a radian for every 450 gone, backward about x,
#  since the model is drawn turned half round
# Run as the piece's item display, with '#tid' its piece and 'rot' its turn

scoreboard players operation @s dr_spin += $TrainSpeed dr_config

data modify storage derailed:train spin set value {angle:0f,axis:[1f,0f,0f]}
execute store result storage derailed:train spin.angle float -0.002222222 run scoreboard players get @s dr_spin
execute as @e[type=item_display,tag=dr_train_wheel,distance=0..] if score @s dr_tid = #tid dr_temp run function derailed:train/_wheel_turn
