
# Starts the next section the queue was asked for, at the next corner along and
#  on the next tier of easy, medium and hard, or all on the tier
#  '#gen_test_tier' names; or stops the queue once none are left

execute if score #q_left dr_var matches ..0 run return run function derailed:dev/gen/_q_stop
scoreboard players remove #q_left dr_var 1

scoreboard players operation #gen_difficulty dr_var = #q_tier dr_var
execute if score #gen_test_tier dr_var matches 0.. run scoreboard players operation #gen_difficulty dr_var = #gen_test_tier dr_var
scoreboard players add #q_tier dr_var 1
execute if score #q_tier dr_var matches 3.. run scoreboard players set #q_tier dr_var 0

scoreboard players operation #gen_corner dr_var = #gen_section dr_var
scoreboard players operation #gen_corner dr_var *= $SectionWidth dr_const
scoreboard players operation #gen_corner dr_var += #gen_origin_x dr_var
execute store result storage derailed:gen q.x int 1 run scoreboard players get #gen_corner dr_var
scoreboard players set #q_step dr_var 1
