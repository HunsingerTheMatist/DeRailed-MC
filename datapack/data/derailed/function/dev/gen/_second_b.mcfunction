
# Draws the second route once it is found, and puts the first route's figures
#  back
# Positioned at the section's corner

# Magenta where the second route runs alone, pink where the two share a tile,
#  and the first route back in red everywhere else it runs
data modify storage derailed:gen e.f set value "_second_mark_at"
function derailed:dev/gen/_each
fill ~ ~3 ~ ~31 ~3 ~15 air strict
kill @e[type=marker,tag=dr_rp,distance=0..]
scoreboard players set #cost_mode dr_var 0

scoreboard players operation #sec_route dr_var = #gen_route dr_var
scoreboard players operation #sec_wet dr_var = #gen_wet dr_var
scoreboard players operation #sec_astray dr_var = #gen_astray dr_var
scoreboard players operation #sec_detour dr_var = #sec_detour_max dr_var
scoreboard players operation #sec_carved dr_var = #gen_carved dr_var
scoreboard players operation #sec_pinch dr_var = #gen_pinch dr_var
scoreboard players operation #sec_opened dr_var = #gen_opened dr_var
scoreboard players operation #sec_reached dr_var = #gen_reached dr_var
scoreboard players operation #gen_route dr_var = #crit_route dr_var
scoreboard players operation #gen_wet dr_var = #crit_wet dr_var
scoreboard players operation #gen_cost dr_var = #crit_cost dr_var
scoreboard players operation #gen_carved dr_var = #crit_carved dr_var
scoreboard players operation #gen_pinch dr_var = #crit_pinch dr_var
scoreboard players operation #gen_opened dr_var = #crit_opened dr_var
scoreboard players set #gen_reached dr_var 1
