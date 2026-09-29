
# Puts the run's totals back as '_lay_snap' kept them, taking the lay about to
#  be thrown away back off them, so that only the lay a section ships with
#  counts

scoreboard players operation #gen_wall_gaps dr_var = #lay_wall_gaps dr_var
scoreboard players operation #gen_wall_big dr_var = #lay_wall_big dr_var
scoreboard players operation #gen_strays dr_var = #lay_strays dr_var
scoreboard players operation #gen_no_river dr_var = #lay_no_river dr_var
scoreboard players operation #riv_fell dr_var = #lay_fell dr_var
scoreboard players operation #riv_joins dr_var = #lay_joins dr_var
scoreboard players operation #riv_lakes dr_var = #lay_lakes dr_var
scoreboard players operation #riv_cuts dr_var = #lay_cuts dr_var
scoreboard players operation #riv_dry dr_var = #lay_dry dr_var
scoreboard players operation #riv_refused dr_var = #lay_refused dr_var
