
# Adds the level the order flood has just finished to what is in hand and what
#  is owed, and returns 1 where the wood in hand falls short of the bridges to
#  the next level and the track below it, '#gen_order_pct' percent over and
#  rounded up, leaving '#order_cut' at 1

scoreboard players operation #op dr_var = #cost_wave dr_var
scoreboard players remove #op dr_var 1
execute store result storage derailed:gen o.p int 1 run scoreboard players get #op dr_var
function derailed:dev/gen/_order_add with storage derailed:gen o

scoreboard players operation #oneed dr_var = #oR dr_var
scoreboard players operation #oneed dr_var += #cost_wave dr_var
scoreboard players operation #oneed dr_var *= #gen_order_pct dr_var
scoreboard players add #oneed dr_var 99
scoreboard players operation #oneed dr_var /= $Hundred dr_const
execute if score #oW dr_var >= #oneed dr_var run return 0
scoreboard players set #order_cut dr_var 1
return 1
