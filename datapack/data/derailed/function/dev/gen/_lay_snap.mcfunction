
# Keeps the run's totals that laying the wall, the rivers and the stray sweep
#  add to, so that a lay thrown away can be taken back off them

scoreboard players operation #lay_wall_gaps dr_var = #gen_wall_gaps dr_var
scoreboard players operation #lay_wall_big dr_var = #gen_wall_big dr_var
scoreboard players operation #lay_strays dr_var = #gen_strays dr_var
scoreboard players operation #lay_no_river dr_var = #gen_no_river dr_var
scoreboard players operation #lay_fell dr_var = #riv_fell dr_var
scoreboard players operation #lay_joins dr_var = #riv_joins dr_var
scoreboard players operation #lay_lakes dr_var = #riv_lakes dr_var
scoreboard players operation #lay_cuts dr_var = #riv_cuts dr_var
scoreboard players operation #lay_dry dr_var = #riv_dry dr_var
scoreboard players operation #lay_refused dr_var = #riv_refused dr_var
