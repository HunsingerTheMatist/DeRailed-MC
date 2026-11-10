# Builds a run of four sections at the test area, on the tiers easy, medium,
#  hard and easy again, or all four on the tier '#gen_test_tier' names, then
#  covers the fourth but for its preview, so the third ends as it looks before
#  the fourth opens; with '#gen_test_preview' at 0 it stops at the third
# Positions itself, so it is safe to call from anywhere

# Nothing is built unless 'init' ran to the end: a run left as the last one
#  left it builds each section past the one before and floods out over
#  whatever stands beside the test area
scoreboard players set #gen_init_ok dr_var 0
function derailed:dev/gen/init
execute unless score #gen_init_ok dr_var matches 1 run return run tellraw @a {text:"[gen] 'dev/gen/init' did not run to the end, so nothing was built; the log names the function that failed to load",color:"red"}

# The tier is put back afterwards, so a run of this changes nothing for whatever
#  is built next
scoreboard players operation #gen_tier_was dr_var = #gen_difficulty dr_var

# After each of the first three sections the run's rerolls so far, and those
#  for too cheap and too expensive, are kept for the survey to tell the
#  sections apart by ('_survey_sections')
scoreboard players set #gen_difficulty dr_var 0
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
function derailed:dev/gen/_test_section
function derailed:dev/gen/_test_keep {n:1}
scoreboard players set #gen_difficulty dr_var 1
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
function derailed:dev/gen/_test_section
function derailed:dev/gen/_test_keep {n:2}
scoreboard players set #gen_difficulty dr_var 2
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
function derailed:dev/gen/_test_section
function derailed:dev/gen/_test_keep {n:3}
execute if score #gen_test_preview dr_var matches 1 run scoreboard players set #gen_difficulty dr_var 0
execute if score #gen_test_preview dr_var matches 1 if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
execute if score #gen_test_preview dr_var matches 1 run function derailed:dev/gen/_test_section

scoreboard players operation #gen_difficulty dr_var = #gen_tier_was dr_var

execute if score #gen_test_preview dr_var matches 1 run function derailed:dev/gen/preview

function derailed:dev/gen/report
