
# Copies the tile of the track this axle is on, 'dr_ai' into the path, onto
#  the axle: its middle, the ways in and out of it and its length
# Run as the axle's marker

execute store result storage derailed:train arg.i int 1 run scoreboard players get @s dr_ai
function derailed:train/_axle_tile with storage derailed:train arg
execute store result score @s dr_acx run data get storage derailed:train tile.x
execute store result score @s dr_acz run data get storage derailed:train tile.z
execute store result score @s dr_adin run data get storage derailed:train tile.din
execute store result score @s dr_adout run data get storage derailed:train tile.dout
execute store result score @s dr_alen run data get storage derailed:train tile.len
