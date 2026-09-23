
# Builds a run of three sections at the test area, one on each tier - easy,
#  medium, then hard
# Positions itself, so it is safe to call from anywhere

function derailed:dev/gen/init

# The tier is put back afterwards, so a run of this changes nothing for whatever
#  is built next
scoreboard players operation #gen_tier_was dr_var = #gen_difficulty dr_var
scoreboard players set #gen_difficulty dr_var 0
function derailed:dev/gen/_test_section
scoreboard players set #gen_difficulty dr_var 1
function derailed:dev/gen/_test_section
scoreboard players set #gen_difficulty dr_var 2
function derailed:dev/gen/_test_section
scoreboard players operation #gen_difficulty dr_var = #gen_tier_was dr_var

function derailed:dev/gen/report
