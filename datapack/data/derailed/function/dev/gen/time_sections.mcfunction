
# Builds one section a tick of what 'dev/gen/survey' builds, the seeds from
#  '#survey_from' on, each as 'dev/gen/test' builds it, easy, medium then hard,
#  going round again after '#survey_count' seeds, and says for each its seed,
#  its tier, its attempts and its fresh starts
# Meant to be run from a command block every tick with the profiler going, so
#  that each tick the profiler times is one section; 'dev/gen/time_sections_reset'
#  starts it over from the first seed

scoreboard players set #gen_marks dr_var 0
scoreboard players set #gen_report dr_var 0
scoreboard players operation #ts_tier_was dr_var = #gen_difficulty dr_var

execute unless score #ts_step dr_var matches 0..2 run function derailed:dev/gen/time_sections_reset
execute if score #ts_step dr_var matches 0 run function derailed:dev/gen/_time_map
execute if score #gen_init_ok dr_var matches 1 run function derailed:dev/gen/_time_section

scoreboard players operation #gen_difficulty dr_var = #ts_tier_was dr_var
scoreboard players set #gen_marks dr_var 1
scoreboard players set #gen_report dr_var 1
