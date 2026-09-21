
# Searches again from the north or south for a section whose carried river barely
#  got anywhere
# Positioned at the section's corner

# The short river is already down and stays down whatever comes of this one, so
#  its markers are cleared and the search starts from nothing
# The starts already tried keep their seeds, which is what stops the search from
#  setting out from the same corner twice
function derailed:dev/gen/_river_wipe

scoreboard players set #riv_short dr_var 0
scoreboard players set #riv_done dr_var 0
scoreboard players set #riv_carry dr_var 0
scoreboard players set #riv_forced dr_var 0
scoreboard players set #riv_len dr_var 0
scoreboard players set #riv_depth dr_var 0
scoreboard players set #riv_best dr_var 0

scoreboard players set #riv_tries dr_var 8
scoreboard players set #riv_rolls dr_var 200
scoreboard players set #riv_steps dr_var 1000

# Nothing is carried, so this one rolls a side for itself and is held to the same
#  length as any other river of its own
scoreboard players add #riv_extra dr_var 1
function derailed:dev/gen/_river_try

# The section has its river either way, since the carried one was laid before this
#  search was ever started
scoreboard players set #riv_done dr_var 1
