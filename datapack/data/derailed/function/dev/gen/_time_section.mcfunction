
# Builds the map's next section on tier '#ts_step', says what it took, and
#  moves on to the next tier, or to the next seed after hard

scoreboard players operation #gen_difficulty dr_var = #ts_step dr_var
scoreboard players operation #ts_rerolls dr_var = #gen_rerolls dr_var
scoreboard players operation #ts_fresh dr_var = #gen_fresh_total dr_var
function derailed:dev/gen/_test_section

scoreboard players operation #ts_att dr_var = #gen_rerolls dr_var
scoreboard players operation #ts_att dr_var -= #ts_rerolls dr_var
scoreboard players add #ts_att dr_var 1
scoreboard players operation #ts_fnew dr_var = #gen_fresh_total dr_var
scoreboard players operation #ts_fnew dr_var -= #ts_fresh dr_var
tellraw @a [{text:"[time] seed ",color:"gray"},{score:{name:"#ts_seed",objective:"dr_var"}},"   tier ",{score:{name:"#ts_step",objective:"dr_var"}},"   attempts ",{score:{name:"#ts_att",objective:"dr_var"}},"   fresh ",{score:{name:"#ts_fnew",objective:"dr_var"}}]

scoreboard players add #ts_step dr_var 1
execute if score #ts_step dr_var matches 3.. run scoreboard players add #ts_seed dr_var 1
execute if score #ts_step dr_var matches 3.. run scoreboard players set #ts_step dr_var 0
scoreboard players operation #ts_end dr_var = #survey_from dr_var
scoreboard players operation #ts_end dr_var += #survey_count dr_var
execute if score #ts_seed dr_var >= #ts_end dr_var run scoreboard players operation #ts_seed dr_var = #survey_from dr_var
