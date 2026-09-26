
# Puts this tile in the stretch being numbered, starting a new one where the
#  tile before it could not be stood on
# Run as the tile's marker

execute if score #sec_after_x dr_var matches 1 run scoreboard players add #sec_last dr_var 1
scoreboard players set #sec_after_x dr_var 0
scoreboard players operation @s dr_str = #sec_last dr_var
