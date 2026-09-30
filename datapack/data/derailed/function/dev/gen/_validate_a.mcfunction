
# Finds the cheapest way across from the entry row to the exit row, cutting
#  through rock where nothing else will do, and measures how much it pinches
#  the train; '_validate_carve' measures it again over what it cut, and
#  '_validate_b' judges it
# Positioned at the section's corner

# The tile the track leaves on is kept off rock wherever any row of the east
#  edge is clear of it: a route made to cut into rock at the very edge, and the
#  section after made to cut its way out, is a crossing nobody chose
scoreboard players set #edge_col dr_var 31
scoreboard players operation #edge_ref dr_var = #gen_entry dr_var
scoreboard players operation #edge_row dr_var = #gen_exit dr_var
function derailed:dev/gen/_edge_clear
scoreboard players operation #gen_exit dr_var = #edge_row dr_var
execute store result storage derailed:gen r.exit int 1 run scoreboard players get #gen_exit dr_var

# The first section's way in is its own to choose, and is kept off rock the
#  same way
execute if score #gen_section dr_var matches 0 run function derailed:dev/gen/_entry_clear

# The glass that marks where the last attempt cut and repainted goes, so that
#  only this attempt's are shown; the glass over what the stray sweep handed on
#  stays, since that was done once for the section
fill ~ ~1 ~ ~31 ~1 ~15 air replace orange_stained_glass strict
fill ~ ~1 ~ ~31 ~1 ~15 air replace yellow_stained_glass strict
fill ~ ~1 ~ ~31 ~1 ~15 air replace magenta_stained_glass strict

scoreboard players set #gen_carved dr_var 0
function derailed:dev/gen/_validate_pass
return 1
