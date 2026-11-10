
# Picks the three points of the start station its ground grows out from, each on
#  a random tile at least 1 in from its edge, columns 1 to 8 on its rail row or
#  the two below, as '#spill_x1' to '#spill_x3' and '#spill_z1' to
#  '#spill_z3', all three again while any two are under 2.1 apart

execute store result score #spill_x1 dr_var run random value 1..8 derailed:gen
execute store result score #spill_z1 dr_var run random value 0..2 derailed:gen
scoreboard players operation #spill_z1 dr_var += #gen_entry dr_var
execute store result score #spill_x2 dr_var run random value 1..8 derailed:gen
execute store result score #spill_z2 dr_var run random value 0..2 derailed:gen
scoreboard players operation #spill_z2 dr_var += #gen_entry dr_var
execute store result score #spill_x3 dr_var run random value 1..8 derailed:gen
execute store result score #spill_z3 dr_var run random value 0..2 derailed:gen
scoreboard players operation #spill_z3 dr_var += #gen_entry dr_var

execute store result score #t dr_temp run function derailed:dev/gen/_start_near {a:1,b:2}
execute if score #t dr_temp matches 1 run return run function derailed:dev/gen/_start_pick
execute store result score #t dr_temp run function derailed:dev/gen/_start_near {a:1,b:3}
execute if score #t dr_temp matches 1 run return run function derailed:dev/gen/_start_pick
execute store result score #t dr_temp run function derailed:dev/gen/_start_near {a:2,b:3}
execute if score #t dr_temp matches 1 run function derailed:dev/gen/_start_pick
