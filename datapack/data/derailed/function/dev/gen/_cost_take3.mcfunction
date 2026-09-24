
# Puts this tile on the wave its cost falls due for the supply check: one for
#  water, the bridge it takes, nothing for anything else, and rock is never
#  stepped onto at all
# Positioned on the tile

execute if block ~ ~ ~ gray_concrete run return 0

scoreboard players set #cost_c dr_var 0
execute if block ~ ~ ~ #derailed:cost_water run scoreboard players set #cost_c dr_var 1

scoreboard players operation #cost_w dr_var = #cost_wave dr_var
scoreboard players operation #cost_w dr_var += #cost_c dr_var
scoreboard players operation #cost_w dr_var %= $Eight dr_const
execute store result storage derailed:gen c.w int 1 run scoreboard players get #cost_w dr_var
function derailed:dev/gen/_cost_summon with storage derailed:gen c
scoreboard players add #cost_pending dr_var 1
