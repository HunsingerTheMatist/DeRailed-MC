
# Numbers the stretch tile '#sec_i' of the first route is in, a tile the
#  second route may not stand on ending the stretch before it, then goes on to
#  the next tile, until the entry

scoreboard players set #sec_x dr_var 0
execute as @e[type=marker,tag=dr_rp_x,distance=0..] if score @s dr_step = #sec_i dr_var run scoreboard players set #sec_x dr_var 1
execute if score #sec_x dr_var matches 1 run scoreboard players set #sec_after_x dr_var 1
execute if score #sec_x dr_var matches 0 as @e[type=marker,tag=dr_rp,tag=!dr_rp_x,distance=0..] if score @s dr_step = #sec_i dr_var run function derailed:dev/gen/_sec_stretch_in

scoreboard players add #sec_i dr_var 1
execute if score #sec_i dr_var <= #sec_n dr_var run function derailed:dev/gen/_sec_stretch
