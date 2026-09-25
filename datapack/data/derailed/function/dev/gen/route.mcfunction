
# Chooses the row the track leaves by, and keeps it with the row it came in on
#  for whoever needs the two, along with the rows the station takes round each
# Positioned at the section's corner

# '#gen_entry' is whatever row the section before left on
function derailed:dev/gen/_pick_exit

# The station stands one row above the rail and two below it, so the rail row
#  keeps off the first row and the last two
execute if score #gen_exit dr_var matches ..0 run scoreboard players set #gen_exit dr_var 1
execute if score #gen_exit dr_var matches 14.. run scoreboard players set #gen_exit dr_var 13

execute store result storage derailed:gen r.entry int 1 run scoreboard players get #gen_entry dr_var
execute store result storage derailed:gen r.exit int 1 run scoreboard players get #gen_exit dr_var

# The last tile the track is laid on: the tile it leaves by, or before a
#  station the tile before its rails, since the station's own three are laid
#  already, and the length of a straight crossing goes with it
scoreboard players set #gen_goal dr_var 31
execute if score #gen_station dr_var matches 1 run scoreboard players set #gen_goal dr_var 28
execute store result storage derailed:gen r.goal int 1 run scoreboard players get #gen_goal dr_var
scoreboard players operation #gen_straight dr_var = #gen_goal dr_var
scoreboard players add #gen_straight dr_var 1

# The rows the station's building and its two rows of ground fall on, and the
#  rows of the yard on this side of the seam, which the section before's
#  station reaches into on its own rail row
scoreboard players operation #gen_srow dr_var = #gen_exit dr_var
scoreboard players remove #gen_srow dr_var 1
execute store result storage derailed:gen r.top int 1 run scoreboard players get #gen_srow dr_var
scoreboard players add #gen_srow dr_var 2
execute store result storage derailed:gen r.low int 1 run scoreboard players get #gen_srow dr_var
scoreboard players add #gen_srow dr_var 1
execute store result storage derailed:gen r.foot int 1 run scoreboard players get #gen_srow dr_var
scoreboard players operation #gen_srow dr_var = #gen_entry dr_var
scoreboard players remove #gen_srow dr_var 1
execute store result storage derailed:gen r.yup int 1 run scoreboard players get #gen_srow dr_var
scoreboard players add #gen_srow dr_var 2
execute store result storage derailed:gen r.ydown int 1 run scoreboard players get #gen_srow dr_var
