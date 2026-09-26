
# Tags this pinched cell 'dr_pinch_end' if it is the cell at either end of a
#  run three or more long, which draws no zone round it
# Run as the cell's marker

scoreboard players operation #pe_run dr_var = @s dr_step
scoreboard players set #pe_n dr_var 0
scoreboard players set #pe_lo dr_var 2147483647
scoreboard players set #pe_hi dr_var -2147483648
execute as @e[type=marker,tag=dr_pinch,distance=0..] if score @s dr_step = #pe_run dr_var run function derailed:dev/gen/_pinch_end_count

execute if score #pe_n dr_var matches 3.. if score @s dr_wave = #pe_lo dr_var run tag @s add dr_pinch_end
execute if score #pe_n dr_var matches 3.. if score @s dr_wave = #pe_hi dr_var run tag @s add dr_pinch_end
