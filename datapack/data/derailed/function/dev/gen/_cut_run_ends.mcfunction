
# Reads what stands at the two ends of this run into '#cut_a', the exit side,
#  and '#cut_b', the entry side
# Run as the run's marker

scoreboard players operation #cut_a dr_var = @s dr_kind
scoreboard players operation #cut_b dr_var = @s dr_id
