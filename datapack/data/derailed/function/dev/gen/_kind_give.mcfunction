
# Gives this seed '#pl_kind' and takes it off the seeds still to be placed
# Run as the seed

scoreboard players operation @s dr_kind = #pl_kind dr_var
tag @s remove dr_place
scoreboard players set #pl_done dr_var 1
