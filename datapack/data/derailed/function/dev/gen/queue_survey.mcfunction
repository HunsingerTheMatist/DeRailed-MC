
# Builds what 'dev/gen/survey' builds through the section queue a step a tick: a
#  map of three sections, easy, medium then hard, from each of '#survey_count'
#  seeds from '#survey_from' on, one after another, and says for each seed what
#  it took; 'dev/gen/queue_survey_1' to '_5' take six seeds apiece, as many as
#  a profile's ten seconds hold
# No section is ever given up on: fresh starts go on for as long as it takes
# '#q_log' at 1 says in chat which step each tick runs
# Positions itself, so it is safe to call from anywhere

scoreboard players operation #qs_seed dr_var = #survey_from dr_var
scoreboard players operation #qs_left dr_var = #survey_count dr_var
function derailed:dev/gen/_q_survey_go
