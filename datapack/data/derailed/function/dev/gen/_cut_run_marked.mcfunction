
# Sets up the marker that stands for a run of rock to be cut: which run, what
#  stands at its exit end, and nothing yet at its entry end
# Run as the marker

tag @s add dr_cut_run
scoreboard players operation @s dr_step = #cut_runs dr_var
scoreboard players operation @s dr_kind = #cut_last dr_var
scoreboard players set @s dr_id -1
