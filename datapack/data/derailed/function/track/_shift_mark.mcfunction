# Makes this new marker the note of a pile a planned move aside adds to and how
#  many items, so the pile can be drawn once the plan is carried out or have
#  them taken back off once it is given up
# Run as the new marker, at the placement it went to

tag @s add dr_shift_to
scoreboard players operation @s dr_count = #curr_item_count dr_arg
