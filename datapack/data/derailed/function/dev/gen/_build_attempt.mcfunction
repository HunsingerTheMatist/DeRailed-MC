
# Rolls the kinds, paints the regions and keeps the section if the track can get
#  across, the players have a second way round, wood and iron come along
#  steadily and water is near the track, otherwise tries again
# Each attempt rolls every seed's kind afresh, keeping the seeds, the chain, the
#  region shapes and the river
# Positioned at the section's corner

# The regions the last attempt's cuts gave tiles go with the cuts
fill ~ ~13 ~ ~31 ~13 ~15 air strict
scoreboard players set #sup_done dr_var 0
scoreboard players set #gen_spread_gaps dr_var 0
scoreboard players set #water_far dr_var -1
scoreboard players set #piece_lost dr_var 0
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

execute positioned ~ ~15 ~ run function derailed:dev/gen/validate

# The second way across is found on every section the track can cross, so the
#  one that ships has it whatever the checks said, and a section without one
#  is a reroll like a cheap one while '#gen_second_reroll' says so
execute if score #gen_reached dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/second

# A section with no second way whose first route is pinched against either end
#  has those pinches opened and the second way looked for again
execute if score #gen_reached dr_var matches 1 if score #sec_reached dr_var matches 0 positioned ~ ~15 ~ run function derailed:dev/gen/_second_retry
execute if score #gen_second_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players add #gen_fail_second dr_var 1
execute if score #gen_second_reroll dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players set #gen_valid dr_var 0

# The cheapest way across is what the band holds a section to, and it is the
#  first route unless the second cut rock, when it is found again over both
#  routes' cuts; a section whose cheapest way falls outside the band is a
#  reroll, cheaper once cut where it fell under the floor, which the first
#  route alone never does, and too expensive where it is over the ceiling
scoreboard players operation #true_cost dr_var = #gen_cost dr_var
scoreboard players operation #true_route dr_var = #gen_route dr_var
scoreboard players operation #true_rate dr_var = #gen_rate dr_var
execute if score #gen_valid dr_var matches 1 if score #sec_reached dr_var matches 1 if score #sec_carved dr_var matches 1.. positioned ~ ~15 ~ run function derailed:dev/gen/_cheapest
execute if score #gen_valid dr_var matches 1 if score #sec_reached dr_var matches 1 if score #sec_carved dr_var matches 0 if score #sec_opened dr_var matches 1.. positioned ~ ~15 ~ run function derailed:dev/gen/_cheapest
scoreboard players set #true_ok dr_var 0
execute if score #true_rate dr_var >= #gen_rate_min dr_var if score #true_rate dr_var <= #gen_rate_max dr_var run scoreboard players set #true_ok dr_var 1
execute if score #gen_rate_free dr_var matches 1 run scoreboard players set #true_ok dr_var 1
execute if score #gen_valid dr_var matches 1 if score #true_ok dr_var matches 0 if score #true_rate dr_var < #gen_rate_min dr_var run scoreboard players add #gen_fail_shortcut dr_var 1
execute if score #gen_valid dr_var matches 1 if score #true_ok dr_var matches 0 if score #true_rate dr_var > #gen_rate_max dr_var run scoreboard players add #gen_fail_costly dr_var 1
execute if score #true_ok dr_var matches 0 run scoreboard players set #gen_valid dr_var 0

# A section usable so far has its wood and iron checked, and one that leaves a
#  window wanting is a reroll while '#gen_window_reroll' says so
execute if score #gen_valid dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/supply
execute if score #gen_window_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #gen_spread_gaps dr_var matches 1.. run scoreboard players add #gen_fail_windows dr_var 1
execute if score #gen_window_reroll dr_var matches 1 if score #gen_spread_gaps dr_var matches 1.. run scoreboard players set #gen_valid dr_var 0

# Then every tile of the cheapest way across has to have water within
#  '#gen_water_reach' steps, on the section as it ships, and one that does not
#  is a reroll while '#gen_water_reroll' says so
execute if score #gen_valid dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_water_check
execute if score #gen_water_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #water_far dr_var matches 1.. run scoreboard players add #gen_fail_water dr_var 1
execute if score #gen_water_reroll dr_var matches 1 if score #water_far dr_var matches 1.. run scoreboard players set #gen_valid dr_var 0
execute if score #gen_valid dr_var matches 1 run return 0

scoreboard players add #gen_rerolls dr_var 1
scoreboard players remove #gen_attempts dr_var 1

# A section that has found no second way twice is built again from its regions
#  as they grew for every attempt after, wall, rivers and all, since drawing the
#  kinds again leaves those as they are, and on hard the wall's rock is mostly
#  what stands in the second way's way
execute if score #gen_reached dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players add #gen_second_misses dr_var 1
execute if score #gen_attempts dr_var matches 1.. if score #gen_second_misses dr_var matches 2.. if score #gen_reached dr_var matches 1 if score #sec_reached dr_var matches 0 run function derailed:dev/gen/_wall_relay

# Painting swaps each region's own block for the kind it rolled, so going again
#  means laying the regions out afresh to have something left to swap
# The first attempt paints straight onto what the section was left standing as,
#  which is why this is here rather than at the head of an attempt
execute if score #gen_attempts dr_var matches 1.. run clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict
execute if score #gen_attempts dr_var matches 1.. run return run function derailed:dev/gen/_build_attempt
scoreboard players add #gen_failed dr_var 1
