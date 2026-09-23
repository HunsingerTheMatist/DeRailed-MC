
# Builds a run of three sections at the test area, one on each tier - easy,
#  medium, then hard - and colours the last one in
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

# A block floating over each seed the track runs through, so the chain can be
#  picked out from above, with the seed it has to end on in gold
# Only the last section still has its seeds, since each section clears them
execute in derailed:game as @e[type=marker,tag=dr_chain,distance=0..] at @s run setblock ~ ~16 ~ red_concrete strict
execute in derailed:game as @e[type=marker,tag=dr_exit,distance=0..] at @s run setblock ~ ~16 ~ gold_block strict

function derailed:dev/gen/report
