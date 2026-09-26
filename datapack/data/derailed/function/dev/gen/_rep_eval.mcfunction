
# Scores the candidate columns of both kinds into '#rep_sw' and '#rep_si', and
#  the two together into '#rep_score'

function derailed:dev/gen/_rep_eval_w
function derailed:dev/gen/_rep_eval_i
scoreboard players operation #rep_score dr_var = #rep_sw dr_var
scoreboard players operation #rep_score dr_var += #rep_si dr_var
