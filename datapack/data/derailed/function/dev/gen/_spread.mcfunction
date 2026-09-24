
# Sees that every thirty-column window ending in this section holds at least
#  two seeds of wood and two of iron within reach of a route, the section
#  before counting for its part, and repaints a region in any window that does
#  not as whichever kind is wanting
# Positioned at the section's corner

execute summon marker run function derailed:dev/gen/_read_corner
scoreboard players operation #sp_dx dr_var = #gen_spread_span dr_var
scoreboard players remove #sp_dx dr_var 1
execute store result storage derailed:gen w.dx int 1 run scoreboard players get #sp_dx dr_var
execute store result storage derailed:gen w.z int 1 run scoreboard players get #gen_cz dr_var

# From the first window that ends in this section, never one starting before
#  the map does, to the last that does
scoreboard players operation #sp_a dr_var = #gen_cx dr_var
scoreboard players operation #sp_a dr_var -= #sp_dx dr_var
scoreboard players operation #sp_a dr_var > #gen_origin_x dr_var
scoreboard players operation #sp_last dr_var = #gen_cx dr_var
scoreboard players add #sp_last dr_var 31
scoreboard players operation #sp_last dr_var -= #sp_dx dr_var

scoreboard players set #sp_rounds dr_var 8
scoreboard players set #gen_spread_gaps dr_var 0
function derailed:dev/gen/_spread_window
