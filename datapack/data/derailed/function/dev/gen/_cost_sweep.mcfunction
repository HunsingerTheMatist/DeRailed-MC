
# Spreads from every tile due on the wave being taken

execute if score #cost_mod dr_var matches 0 as @e[type=marker,tag=dr_f0,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 1 as @e[type=marker,tag=dr_f1,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 2 as @e[type=marker,tag=dr_f2,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 3 as @e[type=marker,tag=dr_f3,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 4 as @e[type=marker,tag=dr_f4,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 5 as @e[type=marker,tag=dr_f5,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 6 as @e[type=marker,tag=dr_f6,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 7 as @e[type=marker,tag=dr_f7,distance=0..] at @s run function derailed:dev/gen/_cost_spread
