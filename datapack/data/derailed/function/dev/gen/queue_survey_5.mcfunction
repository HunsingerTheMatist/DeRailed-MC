
# Runs the queue's survey on seeds 25 to 30, as 'dev/gen/queue_survey' does

scoreboard players set #qs_seed dr_var 25
scoreboard players set #qs_left dr_var 6
function derailed:dev/gen/_q_survey_go
