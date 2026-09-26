
# Takes this region's tiles within reach, column by column,
#  from the candidate iron columns
# A region the supply count cannot take counts toward the windows
#  but not the totals, so its tiles go into or out of those it cannot take
#  as well
# Run as the region's seed

scoreboard players operation #v_i0 dr_var -= @s dr_c0
scoreboard players operation #v_i1 dr_var -= @s dr_c1
scoreboard players operation #v_i2 dr_var -= @s dr_c2
scoreboard players operation #v_i3 dr_var -= @s dr_c3
scoreboard players operation #v_i4 dr_var -= @s dr_c4
scoreboard players operation #v_i5 dr_var -= @s dr_c5
scoreboard players operation #v_i6 dr_var -= @s dr_c6
scoreboard players operation #v_i7 dr_var -= @s dr_c7
scoreboard players operation #v_i8 dr_var -= @s dr_c8
scoreboard players operation #v_i9 dr_var -= @s dr_c9
scoreboard players operation #v_i10 dr_var -= @s dr_c10
scoreboard players operation #v_i11 dr_var -= @s dr_c11
scoreboard players operation #v_i12 dr_var -= @s dr_c12
scoreboard players operation #v_i13 dr_var -= @s dr_c13
scoreboard players operation #v_i14 dr_var -= @s dr_c14
scoreboard players operation #v_i15 dr_var -= @s dr_c15
scoreboard players operation #v_i16 dr_var -= @s dr_c16
scoreboard players operation #v_i17 dr_var -= @s dr_c17
scoreboard players operation #v_i18 dr_var -= @s dr_c18
scoreboard players operation #v_i19 dr_var -= @s dr_c19
scoreboard players operation #v_i20 dr_var -= @s dr_c20
scoreboard players operation #v_i21 dr_var -= @s dr_c21
scoreboard players operation #v_i22 dr_var -= @s dr_c22
scoreboard players operation #v_i23 dr_var -= @s dr_c23
scoreboard players operation #v_i24 dr_var -= @s dr_c24
scoreboard players operation #v_i25 dr_var -= @s dr_c25
scoreboard players operation #v_i26 dr_var -= @s dr_c26
scoreboard players operation #v_i27 dr_var -= @s dr_c27
scoreboard players operation #v_i28 dr_var -= @s dr_c28
scoreboard players operation #v_i29 dr_var -= @s dr_c29
scoreboard players operation #v_i30 dr_var -= @s dr_c30
scoreboard players operation #v_i31 dr_var -= @s dr_c31
execute if entity @s[tag=dr_untake] run scoreboard players operation #v_ui dr_var -= @s dr_ctot
