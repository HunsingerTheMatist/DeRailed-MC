
# Starts an attempt: rolls the kinds and paints the regions, for the first
#  route to be found over
# Each attempt rolls every seed's kind afresh, keeping the seeds and the region
#  shapes, and the wall and the rivers unless they are laid again
# Positioned at the section's corner

# The regions the last attempt's cuts gave tiles go with the cuts
fill ~ ~13 ~ ~31 ~13 ~15 air strict

# A ring of tinted glass round the section, a layer above the routes, that no
#  search steps onto and no cut opens, whatever the section before left on
#  the route layer along the seam
fill ~-1 ~18 ~-1 ~-1 ~18 ~16 tinted_glass replace air strict
fill ~32 ~18 ~-1 ~32 ~18 ~16 tinted_glass replace air strict
fill ~-1 ~18 ~-1 ~32 ~18 ~-1 tinted_glass replace air strict
fill ~-1 ~18 ~16 ~32 ~18 ~16 tinted_glass replace air strict
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ofixed
scoreboard players set #sup_done dr_var 0
scoreboard players set #gen_spread_gaps dr_var 0
scoreboard players set #gen_spread_fail dr_var 0
scoreboard players set #water_far dr_var -1
scoreboard players set #piece_lost dr_var 0
scoreboard players set #order_ran dr_var 0
scoreboard players set #ofixed dr_var 0
kill @e[type=marker,tag=dr_cp,distance=0..]

function derailed:dev/gen/kinds
execute positioned ~ ~5 ~ run function derailed:dev/gen/paint

# What is meant to be seen is the kinds with the river lifted onto them, taking
#  only the blocks the river was cut in and leaving the rest of that layer behind
clone ~ ~5 ~ ~31 ~5 ~15 ~ ~15 ~ strict

# Only the water comes up: what the search gave up on stays down on the layer the
#  river was cut into, where it is there to be looked at when a river wants
#  explaining without standing in the finished section
clone ~ ~9 ~ ~31 ~9 ~15 ~ ~15 ~ strict filtered #derailed:river_cut

# The river is cut as a glaze pointing the way the head came, which is worth
#  having on the layer it was cut into and no use on the finished section, so it
#  comes up and is swapped for plain water
fill ~ ~15 ~ ~31 ~15 ~15 light_blue_concrete replace magenta_glazed_terracotta strict

# The station is drawn over whatever the attempt painted where it stands, and
#  the pieces as the ground they are
execute if score #gen_station dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_station_show with storage derailed:gen r
fill ~ ~15 ~ ~31 ~15 ~15 lime_concrete replace hay_block strict
fill ~ ~15 ~ ~31 ~15 ~15 lime_concrete replace red_nether_bricks strict

scoreboard players set #q_step dr_var 41
return 1
