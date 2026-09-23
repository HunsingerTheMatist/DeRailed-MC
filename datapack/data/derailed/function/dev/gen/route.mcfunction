
# Marks the seeds the track runs through, from the entry row to the exit row
# Positioned at the section's corner

execute summon marker run function derailed:dev/gen/_read_corner

# '#gen_entry' is whatever row the section before left on
function derailed:dev/gen/_pick_exit

# The exit row as a real z, so seeds can be compared against it wherever the
#  section sits
scoreboard players operation #gen_exit_z dr_var = #gen_cz dr_var
scoreboard players operation #gen_exit_z dr_var += #gen_exit dr_var

execute store result storage derailed:gen r.entry int 1 run scoreboard players get #gen_entry dr_var
execute store result storage derailed:gen r.exit int 1 run scoreboard players get #gen_exit dr_var
function derailed:dev/gen/_mark_exit with storage derailed:gen r

# Forward across the section first, then along the east side to the exit seed
# The second leg is what makes the track leave by the chosen row, keeping exits
#  spread across the whole edge
scoreboard players set #gen_steps dr_var 40
function derailed:dev/gen/_start with storage derailed:gen r
execute as @n[type=marker,tag=dr_head,distance=0..] run function derailed:dev/gen/_tail
