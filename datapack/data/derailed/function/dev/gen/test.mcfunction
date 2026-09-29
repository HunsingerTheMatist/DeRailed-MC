# Builds a run of three sections at the test area, one on each tier - easy,
#  medium, then hard - or all three on the tier '#gen_test_tier' names
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

scoreboard players set #gen_difficulty dr_var 0
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
function derailed:dev/gen/_test_section
scoreboard players set #gen_difficulty dr_var 1
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
function derailed:dev/gen/_test_section
scoreboard players set #gen_difficulty dr_var 2
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
function derailed:dev/gen/_test_section

scoreboard players operation #gen_difficulty dr_var = #gen_tier_was dr_var

function derailed:dev/gen/report
