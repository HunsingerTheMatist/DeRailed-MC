
# Moves this tile on a stage: stages 2 and 3 are its variant's structures,
#  placed on the ground over the stage before, and breaking stage 3 clears the
#  tile down to the ground and yields its resource; the station's overhang is
#  put back over a tile beside the station after each
# Run as the tile's mining marker, at it

scoreboard players add @s dr_mine_stage 1
execute if score @s dr_mine_stage matches 4.. run return run function derailed:mine/_done
execute if entity @s[tag=dr_mine_wood] run function derailed:mine/_tree
execute if entity @s[tag=dr_mine_iron] run function derailed:mine/_iron
execute if entity @s[tag=dr_station_near] run function derailed:station/merge
