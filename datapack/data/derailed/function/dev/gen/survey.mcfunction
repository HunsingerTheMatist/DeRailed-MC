
# Builds what 'dev/gen/test' builds from each of '#survey_count' seeds from
#  '#survey_from' on, one a tick, and says for each what it took to build, so
#  that the seeds costliest to build can be found and given to 'dev/gen/profile'
# The stands and the report are left off while it runs and put back as they
#  were once it is done

scoreboard players operation #batch_marks dr_var = #gen_marks dr_var
scoreboard players operation #survey_report dr_var = #gen_report dr_var
scoreboard players set #gen_marks dr_var 0
scoreboard players set #gen_report dr_var 0
scoreboard players operation #survey_seed dr_var = #survey_from dr_var
scoreboard players operation #survey_left dr_var = #survey_count dr_var
function derailed:dev/gen/_survey_next
