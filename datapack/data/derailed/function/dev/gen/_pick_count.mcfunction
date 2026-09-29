
# Counts '#pick' down past this marker, tagging it 'dr_picked' where the count
#  runs out on it
# Run as the marker

scoreboard players remove #pick dr_var 1
execute if score #pick dr_var matches -1 run tag @s add dr_picked
