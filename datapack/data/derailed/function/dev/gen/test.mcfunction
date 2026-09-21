
# Builds a run of three sections at the test area and colours the last one in
# Positions itself, so it is safe to call from anywhere

function derailed:dev/gen/init
function derailed:dev/gen/next_section
function derailed:dev/gen/next_section
function derailed:dev/gen/next_section

# A block floating over each seed the track runs through, so the chain can be
#  picked out from above, with the seed it has to end on in gold
# Only the last section still has its seeds, since each section clears them
execute in derailed:game as @e[type=marker,tag=dr_chain,distance=0..] at @s run setblock ~ ~16 ~ red_concrete strict
execute in derailed:game as @e[type=marker,tag=dr_exit,distance=0..] at @s run setblock ~ ~16 ~ gold_block strict

function derailed:dev/gen/report
