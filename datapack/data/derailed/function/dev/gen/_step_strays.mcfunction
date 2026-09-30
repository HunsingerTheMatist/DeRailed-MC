
# Hands every stray tile to a region beside it, which finishes laying the
#  section out
# Positioned at the section's corner

# A tile left with no edge to another of its own region, which is what a river
#  can leave behind, is handed to a region beside it before the kinds are drawn
# Laid again for the wall's sake, the glass over what the last sweep handed on
#  goes first
execute if score #q_relay dr_var matches 1 run fill ~ ~16 ~ ~31 ~16 ~15 air replace light_blue_stained_glass strict
function derailed:dev/gen/strays
function derailed:dev/gen/_step_laid
return 1
