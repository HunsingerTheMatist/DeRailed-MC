# Takes away the rails and track tiles of team '#train_team''s track, the
#  station's excepted, and of any track tile on no team
# Run in the game's dimension

execute as @e[type=marker,tag=dr_track_tile,tag=!dr_track_station,distance=0..] unless score @s dr_team = @s dr_team run scoreboard players operation @s dr_team = #train_team dr_temp
execute as @e[type=marker,tag=dr_track_tile,tag=!dr_track_station,distance=0..] if score @s dr_team = #train_team dr_temp at @s run fill ~-1 ~ ~-1 ~1 ~ ~1 air replace iron_trapdoor strict
execute as @e[type=marker,tag=dr_track_tile,tag=!dr_track_station,distance=0..] if score @s dr_team = #train_team dr_temp run kill @s
