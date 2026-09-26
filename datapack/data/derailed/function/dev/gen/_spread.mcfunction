
# Counts how many windows of '#gen_spread_span' columns ending in this
#  section, the section before counting for its part, hold fewer than
#  '#gen_spread_need' wood tiles within reach of a route, or as few iron
#  tiles, into '#gen_spread_gaps'
# Positioned at the section's corner, while the supply check's flood is still
#  laid

execute summon marker run function derailed:dev/gen/_read_corner
scoreboard players operation #sp_dx dr_var = #gen_spread_span dr_var
scoreboard players remove #sp_dx dr_var 1

# The first window starts far enough into the section before that it ends on
#  this section's first column; the first section has nothing before it, and
#  its first window starts on its own first column
scoreboard players operation #sp_a0 dr_var = #gen_cx dr_var
execute unless score #gen_section dr_var matches 0 run scoreboard players operation #sp_a0 dr_var -= #sp_dx dr_var

scoreboard players operation #sp_need dr_var = #gen_spread_need dr_var
function derailed:dev/gen/_spread_pass
