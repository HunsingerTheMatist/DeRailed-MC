
# Works out what the routes need before any margin, the costlier of the two on
#  each count: a wood and an iron a rail, and a bridge for every tile of water
#  under the route, '#crit_wet' under the first and '#sec_wet' under the second

scoreboard players operation #need_wood_base dr_var = #gen_route dr_var
scoreboard players operation #need_iron_base dr_var = #gen_route dr_var
execute if score #gen_bridge dr_var matches 1 run scoreboard players operation #need_wood_base dr_var += #crit_wet dr_var
execute if score #gen_bridge dr_var matches 2 run scoreboard players operation #need_iron_base dr_var += #crit_wet dr_var
scoreboard players operation #sup_w2 dr_var = #sec_route dr_var
scoreboard players operation #sup_i2 dr_var = #sec_route dr_var
execute if score #gen_bridge dr_var matches 1 run scoreboard players operation #sup_w2 dr_var += #sec_wet dr_var
execute if score #gen_bridge dr_var matches 2 run scoreboard players operation #sup_i2 dr_var += #sec_wet dr_var
execute if score #sec_reached dr_var matches 1 run scoreboard players operation #need_wood_base dr_var > #sup_w2 dr_var
execute if score #sec_reached dr_var matches 1 run scoreboard players operation #need_iron_base dr_var > #sup_i2 dr_var
