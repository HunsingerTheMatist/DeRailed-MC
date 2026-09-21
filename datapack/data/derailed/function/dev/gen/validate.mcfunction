
# Checks the track can get from the entry row to the exit row without crossing
#  rock, and that the section holds enough wood and iron to build with
# Leaves '#gen_valid' at 1 when the section is usable
# Positioned at the section's corner

# Tiles already reached are kept on a layer two above the section, so the flood
#  can tell where it has been
fill ~ ~2 ~ ~47 ~2 ~15 air strict

# A ring of already-seen tiles around the section, so the flood stays inside it
#  rather than wandering into the section before
# Only the gaps are filled, since the section before left its own route along
#  that edge and it counts as already seen just as well
fill ~-1 ~2 ~-1 ~-1 ~2 ~16 gray_stained_glass replace air strict
fill ~48 ~2 ~-1 ~48 ~2 ~16 gray_stained_glass replace air strict
fill ~-1 ~2 ~-1 ~48 ~2 ~-1 gray_stained_glass replace air strict
fill ~-1 ~2 ~16 ~48 ~2 ~16 gray_stained_glass replace air strict

function derailed:dev/gen/_mark_goal with storage derailed:gen r

scoreboard players set #gen_reached dr_var 0
function derailed:dev/gen/_flood_from with storage derailed:gen r

# The way the flood came is still on the layer above, so the route it found can
#  be walked back from the exit
scoreboard players set #gen_route dr_var 0
scoreboard players set #gen_steps dr_var 400
execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_trace_from with storage derailed:gen r

# Counted as seeds rather than tiles, since a seed is a whole patch and the
#  topping up already works in those terms
execute store result score #gen_wood dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute store result score #gen_iron dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]

scoreboard players set #gen_valid dr_var 0
execute if score #gen_reached dr_var matches 1 if score #gen_wood dr_var matches 4.. if score #gen_iron dr_var matches 4.. run scoreboard players set #gen_valid dr_var 1

execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_fail_path dr_var 1
execute if score #gen_reached dr_var matches 1 if score #gen_valid dr_var matches 0 run scoreboard players add #gen_fail_supply dr_var 1
