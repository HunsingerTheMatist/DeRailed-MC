
# Sets up a marker just left on a tile of the first route
# Run as the marker

tag @s add dr_rp
scoreboard players operation @s dr_step = #gen_route dr_var
scoreboard players operation @s dr_dir = #gen_back dr_var
