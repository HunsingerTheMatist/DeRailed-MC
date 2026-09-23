
# Finds the cheapest way across from the entry row to the exit row, cutting
#  through rock where nothing else will do, and checks that it costs neither too
#  little nor too much a rail
# Leaves '#gen_valid' at 1 when the section is usable
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

# The glass that marks where the last attempt cut goes, so that only this
#  attempt's cuts are shown
fill ~ ~1 ~ ~31 ~1 ~15 air strict

scoreboard players set #gen_carved dr_var 0
function derailed:dev/gen/_validate_pass

# A route that had to cut through rock is measured again over what it cut,
#  since that is the route the players will have; the cut is rock free, so the
#  second pass cuts nothing
execute if score #gen_carved dr_var matches 1.. run scoreboard players add #gen_cuts dr_var 1
execute if score #gen_carved dr_var matches 1.. run function derailed:dev/gen/_validate_pass

# A route that pinches the train more than the tier allows is opened up rather
#  than thrown away, the rock beside its worst run cut back until it passes
scoreboard players set #gen_opened dr_var 0
scoreboard players set #pinch_rounds dr_var 4
execute if score #gen_pinch dr_var > #gen_pinch_max dr_var run scoreboard players add #gen_relieved dr_var 1
function derailed:dev/gen/_pinch_relieve

# The route is judged by what it costs a rail, since the time the players get is
#  the rails they lay, so a longer way across is not a harder one on its own
# Kept in hundredths of a point a rail, so that it stays a whole number
scoreboard players set #gen_rate_raw dr_var 0
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var = #gen_cost dr_var
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var *= $Hundred dr_const
execute if score #gen_route dr_var matches 1.. run scoreboard players operation #gen_rate_raw dr_var /= #gen_route dr_var

# Then raised a little for every rail past a straight crossing, since a longer
#  section is more rails out of the same supply and more time at the same pace
scoreboard players operation #gen_extra dr_var = #gen_route dr_var
scoreboard players operation #gen_extra dr_var -= $SectionWidth dr_const
execute if score #gen_extra dr_var matches ..-1 run scoreboard players set #gen_extra dr_var 0
scoreboard players operation #gen_extra dr_var *= #gen_rail_pen dr_var
scoreboard players add #gen_extra dr_var 100
scoreboard players operation #gen_rate dr_var = #gen_rate_raw dr_var
scoreboard players operation #gen_rate dr_var *= #gen_extra dr_var
scoreboard players operation #gen_rate dr_var /= $Hundred dr_const

execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_rate_tally

# Counted for the report, as seeds rather than tiles, since a seed is a whole
#  patch
execute store result score #gen_wood dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute store result score #gen_iron dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]

# Hard wants the train pinched somewhere, and a route that never does is a
#  reroll like a cheap one
scoreboard players set #gen_valid dr_var 0
execute if score #gen_reached dr_var matches 1 if score #gen_rate dr_var >= #gen_rate_min dr_var if score #gen_rate dr_var <= #gen_rate_max dr_var if score #gen_pinch dr_var >= #gen_pinch_min dr_var run scoreboard players set #gen_valid dr_var 1

execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_fail_path dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_rate dr_var < #gen_rate_min dr_var run scoreboard players add #gen_fail_cheap dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_rate dr_var > #gen_rate_max dr_var run scoreboard players add #gen_fail_dear dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var < #gen_pinch_min dr_var run scoreboard players add #gen_fail_flat dr_var 1
