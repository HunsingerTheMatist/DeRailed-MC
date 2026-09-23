
# Chooses the row the track leaves by, and keeps it with the row it came in on
#  for whoever needs the two
# Positioned at the section's corner

# '#gen_entry' is whatever row the section before left on
function derailed:dev/gen/_pick_exit

execute store result storage derailed:gen r.entry int 1 run scoreboard players get #gen_entry dr_var
execute store result storage derailed:gen r.exit int 1 run scoreboard players get #gen_exit dr_var
