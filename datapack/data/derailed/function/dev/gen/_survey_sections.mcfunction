
# Says the attempts each of a test's three sections took, and its rerolls for
#  too cheap and too expensive, from what 'test' kept after each

scoreboard players operation #srv_a1 dr_var = #srv_r1 dr_var
scoreboard players operation #srv_a2 dr_var = #srv_r2 dr_var
scoreboard players operation #srv_a2 dr_var -= #srv_r1 dr_var
scoreboard players operation #srv_a3 dr_var = #srv_r3 dr_var
scoreboard players operation #srv_a3 dr_var -= #srv_r2 dr_var
scoreboard players add #srv_a1 dr_var 1
scoreboard players add #srv_a2 dr_var 1
scoreboard players add #srv_a3 dr_var 1

scoreboard players operation #srv_d2 dr_var = #srv_c2 dr_var
scoreboard players operation #srv_d2 dr_var -= #srv_c1 dr_var
scoreboard players operation #srv_d3 dr_var = #srv_c3 dr_var
scoreboard players operation #srv_d3 dr_var -= #srv_c2 dr_var
scoreboard players operation #srv_y2 dr_var = #srv_x2 dr_var
scoreboard players operation #srv_y2 dr_var -= #srv_x1 dr_var
scoreboard players operation #srv_y3 dr_var = #srv_x3 dr_var
scoreboard players operation #srv_y3 dr_var -= #srv_x2 dr_var

tellraw @a [{text:"[survey]   by section: attempts ",color:"gray"},{score:{name:"#srv_a1",objective:"dr_var"}}," ",{score:{name:"#srv_a2",objective:"dr_var"}}," ",{score:{name:"#srv_a3",objective:"dr_var"}},"   too cheap ",{score:{name:"#srv_c1",objective:"dr_var"}}," ",{score:{name:"#srv_d2",objective:"dr_var"}}," ",{score:{name:"#srv_d3",objective:"dr_var"}},"   too expensive ",{score:{name:"#srv_x1",objective:"dr_var"}}," ",{score:{name:"#srv_y2",objective:"dr_var"}}," ",{score:{name:"#srv_y3",objective:"dr_var"}}]
