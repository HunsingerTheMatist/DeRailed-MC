
# Builds one whole section, drawing the kinds again up to '#gen_attempt_count'
#  times until it passes every check, and laying it again from new seeds up to
#  '#gen_fresh_max' times when those run out
# Positioned at the section's corner

# The tier sets what the cheapest way across may cost a rail, in hundredths of a
#  point, counting ground 1, wood or iron 2 and water 4 a tile and a little more
#  for every rail past a straight crossing: under the floor is too easy a
#  section and over the ceiling too hard
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_min dr_var 140
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_max dr_var 200
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_min dr_var 160
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_max dr_var 250
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_min dr_var 220
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_max dr_var 300

# Whether a route outside that band is let through rather than rerolled, which
#  is how a tier's band is measured
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_rate_free dr_var 0
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_rate_free dr_var 0
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_rate_free dr_var 0

# And how much the route may pinch the train, a run of n pinched boxes
#  counting n cubed: over the ceiling is opened up rather than thrown away, and
#  hard wants some
# Easy allows none, medium two single rows of rock either side far enough apart
#  not to touch, two boxes each, and hard from one such row up to a corridor
#  five long, which is six boxes
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_pinch_max dr_var 0
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_pinch_min dr_var 0
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_pinch_max dr_var 16
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_pinch_min dr_var 0
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_pinch_max dr_var 216
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_pinch_min dr_var 8

# The chance, in percent, that a section gets each piece; a piece the players
#  cannot get to is dropped, which on hard's rock is about one in six, so hard
#  places them more often to ship about as many
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_piece_odds dr_var 50
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_piece_odds dr_var 50
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_piece_odds dr_var 60

# And the fewest regions of each kind a section may have, met by holding back
#  the last seeds drawn for whatever is still owed; rock's, since rock is what
#  makes a section hard to move about in rather than just expensive to cross
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_rock dr_var 3
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_rock dr_var 4

# And the fewest wood and iron regions, since the routes are laid from them:
#  hard's routes cost the most and its rock leaves the least to repaint, so it
#  holds one more of each
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_wood dr_var 3
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_iron dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_wood dr_var 3
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_iron dr_var 3
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_wood dr_var 4
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_iron dr_var 4

# And the fewest water regions
execute if score #gen_difficulty dr_var matches 0 run scoreboard players set #gen_min_water dr_var 2
execute if score #gen_difficulty dr_var matches 1 run scoreboard players set #gen_min_water dr_var 2
execute if score #gen_difficulty dr_var matches 2 run scoreboard players set #gen_min_water dr_var 2

# What the report reads about the second route and the supply starts from
#  nothing, since a section the track never gets across skips both
scoreboard players set #sec_reached dr_var 0
scoreboard players set #sup_wood dr_var 0
scoreboard players set #sup_iron dr_var 0
scoreboard players set #need_wood dr_var 0
scoreboard players set #need_iron dr_var 0
scoreboard players set #sup_bridges dr_var 0
scoreboard players set #sup_short dr_var 0
scoreboard players set #gen_spread_gaps dr_var 0
data modify storage derailed:gen spread_gaps set value []
data modify storage derailed:gen spread_cols set value []

# The row the track leaves by comes first, since the station stands on it and
#  everything else grows round the station: its tiles are laid before a seed is
#  placed, and its edge leaves notes for the section after to read as ground
function derailed:dev/gen/route
execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_station_stamp with storage derailed:gen r
execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_station_notes with storage derailed:gen r

# The notes the seam kept from the section before last are done with
kill @e[type=marker,tag=dr_edge_kept,distance=0..]

function derailed:dev/gen/_lay_regions

# Held for a look at the river, the section stops here with nothing drawn over it
execute if score #gen_riv_hold dr_var matches 1 run return 0

# What the report counted of the section before's last columns is kept before
#  any attempt counts this section's
execute if score #gen_report dr_var matches 1 run function derailed:dev/gen/_rim_keep

# A few attempts on these regions, then the section is started afresh while
#  fresh starts are left
scoreboard players operation #gen_attempts dr_var = #gen_attempt_count dr_var
scoreboard players operation #gen_fresh_left dr_var = #gen_fresh_max dr_var
scoreboard players set #gen_second_misses dr_var 0
function derailed:dev/gen/_build_attempt

# Whether there is enough wood and iron within reach to lay either route, for
#  a section that ships without its last attempt having got as far as asking
execute if score #sup_done dr_var matches 0 positioned ~ ~15 ~ run function derailed:dev/gen/supply

# Only the attempt that ships counts toward the run's totals, and only its
#  columns are handed on to the section after
scoreboard players operation #gen_tail_gaps dr_var += #gen_tail_gap dr_var
scoreboard players operation #gen_spread_total dr_var += #gen_spread_gaps dr_var
execute if score #sup_short dr_var matches 1 run scoreboard players add #gen_supply_short dr_var 1
scoreboard players operation #gen_repaints dr_var += #gen_repainted dr_var
scoreboard players operation #gen_repair_swaps_total dr_var += #gen_repair_swaps dr_var
scoreboard players operation #gen_repair_paints_total dr_var += #gen_repair_paints dr_var
data modify storage derailed:gen prev_cols set from storage derailed:gen sec_cols
scoreboard players operation #gen_pieces_placed dr_var += #piece_cows dr_var
scoreboard players operation #gen_pieces_placed dr_var += #piece_bandits dr_var
scoreboard players operation #gen_pieces_dropped dr_var += #piece_lost dr_var
scoreboard players operation #gen_order_fixed dr_var += #ofixed dr_var

# A piece the section ships without has black glass on its northwestern tile
execute as @e[type=marker,tag=dr_piece,tag=dr_dropped,dx=31,dy=0,dz=15] at @s run setblock ~ ~16 ~ black_stained_glass strict

# For the report, once, on the section as it ships: what each route costs to
#  lay across it, priced the way the flood prices the first, and what the tiles
#  either side of its western seam are
scoreboard players set #price_first dr_var 0
scoreboard players set #price_second dr_var 0
execute if score #gen_report dr_var matches 1 if score #sec_reached dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_price_routes
execute if score #gen_report dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_rim_look

# The ring the attempts laid round the section goes, since the sections either
#  side have their own tiles there
fill ~-1 ~18 ~-1 ~-1 ~18 ~16 air replace tinted_glass strict
fill ~32 ~18 ~-1 ~32 ~18 ~16 air replace tinted_glass strict
fill ~-1 ~18 ~-1 ~32 ~18 ~-1 air replace tinted_glass strict
fill ~-1 ~18 ~16 ~32 ~18 ~16 air replace tinted_glass strict

# The notes left along the eastern edge only learn their kind once the section is
#  settled, since a reroll would have changed it under them
execute as @e[type=marker,tag=dr_edge,tag=!dr_prefab,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_edge_kind
