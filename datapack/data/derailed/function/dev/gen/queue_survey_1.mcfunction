
# Runs the queue's survey on seeds 1 to 6, as 'dev/gen/queue_survey' does

scoreboard players set #qs_seed dr_var 1
scoreboard players set #qs_left dr_var 6
function derailed:dev/gen/_q_survey_go
