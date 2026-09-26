
# Scores the candidate columns once a change has been laid onto them, into
#  '#rep_score': only the kinds the change touches are scored again, the
#  other's score as the section stands being taken as it is
# A change touches '#rep_w', and the other resource too where the region
#  turned was that resource, '#rep_k'

execute if score #rep_k dr_var matches 1..2 run return run function derailed:dev/gen/_rep_eval

execute if score #rep_w dr_var matches 1 run function derailed:dev/gen/_rep_eval_w
execute if score #rep_w dr_var matches 1 run scoreboard players operation #rep_score dr_var = #rep_sw dr_var
execute if score #rep_w dr_var matches 1 run scoreboard players operation #rep_score dr_var += #rep_now_i dr_var
execute if score #rep_w dr_var matches 2 run function derailed:dev/gen/_rep_eval_i
execute if score #rep_w dr_var matches 2 run scoreboard players operation #rep_score dr_var = #rep_si dr_var
execute if score #rep_w dr_var matches 2 run scoreboard players operation #rep_score dr_var += #rep_now_w dr_var
