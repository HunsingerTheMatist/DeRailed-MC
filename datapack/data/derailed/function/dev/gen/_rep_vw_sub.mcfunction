
# Takes this region's tiles within reach, column by column,
#  from the candidate wood columns
# A region the supply count cannot take counts toward the windows
#  but not the totals, so its tiles go into or out of those it cannot take
#  as well
# Run as the region's seed

scoreboard players operation #v_w0 dr_var -= @s dr_c0
scoreboard players operation #v_w1 dr_var -= @s dr_c1
scoreboard players operation #v_w2 dr_var -= @s dr_c2
scoreboard players operation #v_w3 dr_var -= @s dr_c3
scoreboard players operation #v_w4 dr_var -= @s dr_c4
scoreboard players operation #v_w5 dr_var -= @s dr_c5
scoreboard players operation #v_w6 dr_var -= @s dr_c6
scoreboard players operation #v_w7 dr_var -= @s dr_c7
scoreboard players operation #v_w8 dr_var -= @s dr_c8
scoreboard players operation #v_w9 dr_var -= @s dr_c9
scoreboard players operation #v_w10 dr_var -= @s dr_c10
scoreboard players operation #v_w11 dr_var -= @s dr_c11
scoreboard players operation #v_w12 dr_var -= @s dr_c12
scoreboard players operation #v_w13 dr_var -= @s dr_c13
scoreboard players operation #v_w14 dr_var -= @s dr_c14
scoreboard players operation #v_w15 dr_var -= @s dr_c15
scoreboard players operation #v_w16 dr_var -= @s dr_c16
scoreboard players operation #v_w17 dr_var -= @s dr_c17
scoreboard players operation #v_w18 dr_var -= @s dr_c18
scoreboard players operation #v_w19 dr_var -= @s dr_c19
scoreboard players operation #v_w20 dr_var -= @s dr_c20
scoreboard players operation #v_w21 dr_var -= @s dr_c21
scoreboard players operation #v_w22 dr_var -= @s dr_c22
scoreboard players operation #v_w23 dr_var -= @s dr_c23
scoreboard players operation #v_w24 dr_var -= @s dr_c24
scoreboard players operation #v_w25 dr_var -= @s dr_c25
scoreboard players operation #v_w26 dr_var -= @s dr_c26
scoreboard players operation #v_w27 dr_var -= @s dr_c27
scoreboard players operation #v_w28 dr_var -= @s dr_c28
scoreboard players operation #v_w29 dr_var -= @s dr_c29
scoreboard players operation #v_w30 dr_var -= @s dr_c30
scoreboard players operation #v_w31 dr_var -= @s dr_c31
execute if entity @s[tag=dr_untake] run scoreboard players operation #v_uw dr_var -= @s dr_ctot
