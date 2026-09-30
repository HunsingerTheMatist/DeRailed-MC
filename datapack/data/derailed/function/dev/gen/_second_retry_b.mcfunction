
# Judges the first route again once its ends are opened, before the second way
#  is looked for once more
# Positioned at the section's corner

function derailed:dev/gen/_validate_judge

# Opening the ends can take a section under its floor or its band, which is
#  then a reroll like any other and counted the same way
execute if score #gen_reached dr_var matches 1 if score #gen_rate_free dr_var matches 0 if score #gen_rate dr_var < #gen_rate_min dr_var run scoreboard players add #gen_fail_cheap dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var < #gen_pinch_min dr_var run scoreboard players add #gen_fail_flat dr_var 1

# The search that found nothing is counted again if this one finds nothing too
scoreboard players remove #gen_no_second dr_var 1
