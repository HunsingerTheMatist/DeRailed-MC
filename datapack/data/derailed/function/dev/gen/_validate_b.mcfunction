
# Judges the first route once it is opened up: what it costs a rail against the
#  tier's band, and whether it pinches the train enough, and counts the section
#  for the report
# Positioned at the section's corner

function derailed:dev/gen/_validate_judge

execute if score #gen_reached dr_var matches 1 run function derailed:dev/gen/_rate_tally

# Counted for the report, as seeds rather than tiles, since a seed is a whole
#  patch
execute store result score #gen_wood dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute store result score #gen_iron dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]

execute if score #gen_reached dr_var matches 0 run scoreboard players add #gen_fail_path dr_var 1
# An attempt both too cheap and too open counts once, as too cheap
scoreboard players set #v_cheap dr_var 0
execute if score #gen_reached dr_var matches 1 if score #gen_rate_free dr_var matches 0 if score #gen_rate dr_var < #gen_rate_min dr_var run scoreboard players set #v_cheap dr_var 1
execute if score #v_cheap dr_var matches 1 run scoreboard players add #gen_fail_cheap dr_var 1
execute if score #v_cheap dr_var matches 0 if score #gen_reached dr_var matches 1 if score #gen_pinch dr_var < #gen_pinch_min dr_var run scoreboard players add #gen_fail_flat dr_var 1
