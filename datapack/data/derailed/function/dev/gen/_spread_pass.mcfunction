
# Goes through every window from the first, a column at a time, over the
#  section's columns counted afresh
# The columns are fed through the window in order: the last of the section
#  before's, as many as the first window takes, then this section's; each one
#  taken in is added to the running totals, and once the window is full the
#  oldest is dropped from them
# Positioned at the section's corner

scoreboard players set #gen_spread_gaps dr_var 0
function derailed:dev/gen/_col_scan

data modify storage derailed:gen seq set value []
execute unless score #gen_section dr_var matches 0 run data modify storage derailed:gen seq set from storage derailed:gen prev_cols
scoreboard players operation #sp_drop dr_var = $SectionWidth dr_const
scoreboard players operation #sp_drop dr_var -= #sp_dx dr_var
execute unless score #gen_section dr_var matches 0 run function derailed:dev/gen/_spread_drop
data modify storage derailed:gen tmp set from storage derailed:gen cols
function derailed:dev/gen/_spread_copy

data modify storage derailed:gen fifo set value []
scoreboard players set #sp_wood dr_var 0
scoreboard players set #sp_iron dr_var 0
scoreboard players set #sp_filled dr_var 0
function derailed:dev/gen/_spread_step
