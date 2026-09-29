
# Adds level '#ok' less one to what is in hand and judges whether level '#ok'
#  can be paid for, then moves on to the next while it could and levels are
#  left

scoreboard players operation #op dr_var = #ok dr_var
scoreboard players remove #op dr_var 1
execute store result storage derailed:gen o.k int 1 run scoreboard players get #ok dr_var
execute store result storage derailed:gen o.p int 1 run scoreboard players get #op dr_var
function derailed:dev/gen/_order_add with storage derailed:gen o
function derailed:dev/gen/_order_judge with storage derailed:gen o
scoreboard players add #ok dr_var 1
execute if score #oL dr_var matches -1 if score #ok dr_var <= #omax dr_var run function derailed:dev/gen/_order_step
