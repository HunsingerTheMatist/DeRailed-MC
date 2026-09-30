
# Starts the section: the tier's bounds, what the last section's attempts
#  counted cleared, and the station on the row the track leaves by
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

# A section starts strict, and is loosened only after many fresh starts
scoreboard players set #gen_lenient dr_var 0

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

scoreboard players set #q_step dr_var 2
return 1
