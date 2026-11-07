# Keeps a light at the eyes of every player in the game and riding every piece
#  of a train, which the night post effect lights the world round, and tells
#  every light how dark it is
# Run in the game's dimension

# How dark it is, 0 to 255, along the day's fades
execute store result score #day dr_temp run time of derailed:game query derailed:game_day
scoreboard players set #night dr_temp 0
execute if score #day dr_temp >= $Night dr_const if score #day dr_temp < $Dawn dr_const run scoreboard players set #night dr_temp 255
execute if score #day dr_temp >= $Dusk dr_const if score #day dr_temp < $Night dr_const run function derailed:light/_fade {list:"dusk",start:"$Dusk"}
execute if score #day dr_temp >= $Dawn dr_const run function derailed:light/_fade {list:"dawn",start:"$Dawn"}
execute unless score #night dr_temp = #night dr_var run function derailed:light/_retell

# A piece's light goes out once the piece is gone, and a player's once they
#  have left the game or are spectating
execute as @e[type=item_display,tag=dr_light_piece,distance=0..] unless function derailed:light/_ridden run kill @s
execute as @a[distance=0..,gamemode=!spectator] at @s run function derailed:light/_follow
kill @e[type=item_display,tag=dr_light_player,tag=!dr_light_kept,distance=0..]
tag @e[type=item_display,tag=dr_light_kept,distance=0..] remove dr_light_kept

execute as @e[type=item_display,tag=dr_train_piece,distance=0..] unless function derailed:light/_lit at @s run function derailed:light/_add_piece
