
# Builds the map from seed '#survey_seed' and says what it took: its attempts
#  over all three sections, its fresh starts, its detour searches for second
#  routes and the sections it gave up on; then the next seed on the tick after
#  while any are left
# A scheduled function runs in the overworld, and the run clears its markers
#  in whatever dimension it is run in, so it is run in the one the test area
#  is in

execute store result storage derailed:gen prof.seed int 1 run scoreboard players get #survey_seed dr_var
function derailed:dev/gen/_reseed with storage derailed:gen prof
execute in derailed:game run function derailed:dev/gen/test

scoreboard players operation #survey_att dr_var = #gen_rerolls dr_var
scoreboard players add #survey_att dr_var 3
tellraw @a [{text:"[survey] seed ",color:"gray"},{score:{name:"#survey_seed",objective:"dr_var"}},"   attempts: ",{score:{name:"#survey_att",objective:"dr_var"}},"   started afresh: ",{score:{name:"#gen_fresh_total",objective:"dr_var"}},"   detour searches: ",{score:{name:"#gen_searches",objective:"dr_var"}},"   gave up on: ",{score:{name:"#gen_failed",objective:"dr_var"}}]
tellraw @a [{text:"[survey]   rerolled for no way across: ",color:"gray"},{score:{name:"#gen_fail_path",objective:"dr_var"}},"   too cheap: ",{score:{name:"#gen_fail_cheap",objective:"dr_var"}},"   too open: ",{score:{name:"#gen_fail_flat",objective:"dr_var"}},"   no second way: ",{score:{name:"#gen_fail_second",objective:"dr_var"}},"   cheaper once cut: ",{score:{name:"#gen_fail_shortcut",objective:"dr_var"}},"   too expensive: ",{score:{name:"#gen_fail_costly",objective:"dr_var"}},"   wood out of order: ",{score:{name:"#gen_fail_order",objective:"dr_var"}},"   windows wanting: ",{score:{name:"#gen_fail_windows",objective:"dr_var"}},"   water too far: ",{score:{name:"#gen_fail_water",objective:"dr_var"}}]
scoreboard players add #survey_seed dr_var 1
scoreboard players remove #survey_left dr_var 1
execute if score #survey_left dr_var matches 1.. run schedule function derailed:dev/gen/_survey_next 1t
execute if score #survey_left dr_var matches ..0 run scoreboard players operation #gen_marks dr_var = #batch_marks dr_var
execute if score #survey_left dr_var matches ..0 run scoreboard players operation #gen_report dr_var = #survey_report dr_var
