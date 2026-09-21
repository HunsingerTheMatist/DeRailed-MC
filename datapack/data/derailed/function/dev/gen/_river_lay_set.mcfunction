
# Sets up a river tile just laid
# Run as the marker
# The depth it is laid at is what lets a whole branch be written off at once when
#  the head comes back past the choice that started it

tag @s add dr_riv_path
scoreboard players operation @s dr_depth = #riv_depth dr_var

# How far into the search this tile was laid, which climbs along whatever line is
#  standing: backtracking only ever takes the tail off and puts a later one on,
#  so of two tiles next to each other the higher is always the further along
scoreboard players operation @s dr_step = #riv_step dr_var

# Which way the head was going when it got here, which is only there to point the
#  glaze the right way where the search is being looked at
scoreboard players operation @s dr_dir = #riv_dir dr_var
