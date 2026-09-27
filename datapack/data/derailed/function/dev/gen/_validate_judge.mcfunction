
# Judges the route the section has settled on: what it costs a rail, and
#  whether that and its pinching make the section usable, left in '#gen_valid'
# Positioned at the section's corner

function derailed:dev/gen/_rate_calc

# A route under the tier's floor is a reroll, unless the tier's band is being
#  measured, since the cheapest way across can only come out cheaper still;
#  the ceiling is held to that cheapest way once the second route is found,
#  and hard wants the train pinched somewhere, so a route that never does is a
#  reroll like a cheap one
scoreboard players set #gen_rate_ok dr_var 0
execute if score #gen_rate dr_var >= #gen_rate_min dr_var run scoreboard players set #gen_rate_ok dr_var 1
execute if score #gen_rate_free dr_var matches 1 run scoreboard players set #gen_rate_ok dr_var 1
scoreboard players set #gen_valid dr_var 0
execute if score #gen_reached dr_var matches 1 if score #gen_rate_ok dr_var matches 1 if score #gen_pinch dr_var >= #gen_pinch_min dr_var run scoreboard players set #gen_valid dr_var 1
