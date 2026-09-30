
# Takes the river's head one corner further, or sends it back where it came from
# Run as the head, positioned on it

# A walk that has taken '#riv_slice_max' steps since '#riv_slice' was last set
#  to 0 stops where it stands, before this step is taken, to be picked up again
#  from the head by '_river_walk_on'
scoreboard players add #riv_slice dr_var 1
execute if score #riv_slice dr_var > #riv_slice_max dr_var run return run scoreboard players set #riv_paused dr_var 1

scoreboard players remove #riv_steps dr_var 1
execute if score #riv_steps dr_var matches ..0 run return run function derailed:dev/gen/_river_spent

function derailed:dev/gen/_river_look

# Leaving by the border across from the one it set out from is the river
#  finished, and so is coming up against water already laid, so long as it has
#  run far enough to be worth having
# A river that has not is turned back rather than kept: the search has a whole
#  section of boundaries to look through for a longer way out
scoreboard players set #riv_out dr_var 0
execute if score #riv_exit dr_var matches 0 unless score #riv_exit dr_var = #riv_side dr_var run scoreboard players set #riv_out dr_var 1
execute if score #riv_exit dr_var matches 2 unless score #riv_exit dr_var = #riv_side dr_var run scoreboard players set #riv_out dr_var 1
execute if score #riv_join dr_var matches 1 run scoreboard players set #riv_out dr_var 1

execute if score #riv_out dr_var matches 1 if score #riv_len dr_var >= #riv_need dr_var run return run function derailed:dev/gen/_river_done
execute if score #riv_out dr_var matches 1 run return run function derailed:dev/gen/_river_back

# A river long past the width of a section is wandering the boundaries rather
#  than crossing on them, so the branch is given up and a shorter way looked for
execute if score #riv_len dr_var > #gen_riv_max dr_var run return run function derailed:dev/gen/_river_back

scoreboard players operation #riv_tot dr_var = #riv_v0 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v1 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v2 dr_var

# Nowhere left to go, so the branch this head is on is spent
execute if score #riv_tot dr_var matches 0 run return run function derailed:dev/gen/_river_back

# More than one way on is a choice worth being able to come back to
execute if score #riv_tot dr_var matches 2.. run function derailed:dev/gen/_river_node

function derailed:dev/gen/_river_pick
