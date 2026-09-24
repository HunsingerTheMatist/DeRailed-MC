
# Counts the wood and iron seeds within reach in the window starting at
#  '#sp_a', repaints a region in this section's part of it where either is
#  wanting and looks at the window again, and moves on to the window one
#  column east once it passes or nothing more can be done for it
# Positioned at the section's corner

execute store result storage derailed:gen w.x int 1 run scoreboard players get #sp_a dr_var
function derailed:dev/gen/_spread_count with storage derailed:gen w

scoreboard players set #sup_want dr_var 0
execute if score #sp_iron dr_var < #gen_spread_min dr_var run scoreboard players set #sup_want dr_var 2
execute if score #sp_wood dr_var < #gen_spread_min dr_var run scoreboard players set #sup_want dr_var 1

scoreboard players set #sp_fixed dr_var 0
execute if score #sup_want dr_var matches 1.. if score #sp_rounds dr_var matches 1.. run function derailed:dev/gen/_spread_fix
execute if score #sp_fixed dr_var matches 1 run return run function derailed:dev/gen/_spread_window

# A window still wanting has nothing in this section left to give it, and is
#  counted
execute if score #sup_want dr_var matches 1.. run scoreboard players add #gen_spread_gaps dr_var 1

scoreboard players add #sp_a dr_var 1
execute if score #sp_a dr_var <= #sp_last dr_var run function derailed:dev/gen/_spread_window
