
# Takes the next column into the window, dropping the oldest once the window
#  is over full, and judges the window whenever it is full
# Positioned at the section's corner

execute unless data storage derailed:gen seq[0] run return 0

execute store result score #sp_c dr_var run data get storage derailed:gen seq[0].w
scoreboard players operation #sp_wood dr_var += #sp_c dr_var
execute store result score #sp_c dr_var run data get storage derailed:gen seq[0].i
scoreboard players operation #sp_iron dr_var += #sp_c dr_var
data modify storage derailed:gen fifo append from storage derailed:gen seq[0]
data remove storage derailed:gen seq[0]
scoreboard players add #sp_filled dr_var 1
scoreboard players add #sp_col dr_var 1

execute if score #sp_filled dr_var > #gen_spread_span dr_var run function derailed:dev/gen/_spread_pop
execute if score #sp_filled dr_var >= #gen_spread_span dr_var run return run function derailed:dev/gen/_spread_judge
function derailed:dev/gen/_spread_step
