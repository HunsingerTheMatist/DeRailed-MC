
# Sets up a tile just claimed, due to wake on wave 7 of the eight
# Run as the marker just summoned on it, which arrives already knowing its region
#  and so never has to read it back off the tile

tag @s add dr_w7
scoreboard players operation @s dr_id = #gen_id dr_var
