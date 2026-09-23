
# Wakes the rock parked for this wave, spreads from every tile due, then moves
#  on to the next wave, and to the next level once this one is spent
# Eight tags carry the waves: the dearest tile falls due four waves on, so a
#  tile put on a later wave never shares a tag with the wave being taken

scoreboard players operation #cost_mod dr_var = #cost_wave dr_var
scoreboard players operation #cost_mod dr_var %= $Eight dr_const

# Looked for only while any are parked for this level, since the sweep costs as
#  much as a hundred block tests
execute if score #cost_waiting dr_var matches 1.. as @e[type=marker,tag=dr_rock_wait,distance=0..] if score @s dr_level = #cost_level dr_var if score @s dr_wave = #cost_wave dr_var at @s run function derailed:dev/gen/_cost_wake

execute if score #cost_mod dr_var matches 0 as @e[type=marker,tag=dr_f0,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 1 as @e[type=marker,tag=dr_f1,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 2 as @e[type=marker,tag=dr_f2,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 3 as @e[type=marker,tag=dr_f3,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 4 as @e[type=marker,tag=dr_f4,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 5 as @e[type=marker,tag=dr_f5,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 6 as @e[type=marker,tag=dr_f6,distance=0..] at @s run function derailed:dev/gen/_cost_spread
execute if score #cost_mod dr_var matches 7 as @e[type=marker,tag=dr_f7,distance=0..] at @s run function derailed:dev/gen/_cost_spread

scoreboard players add #cost_wave dr_var 1

# Reaching the exit ends it, since nothing taken later could get there for less
execute if score #gen_reached dr_var matches 1 run return 0
execute if score #cost_wave dr_var matches ..400 if score #cost_pending dr_var matches 1.. run return run function derailed:dev/gen/_cost_wave
execute if score #cost_wave dr_var matches ..400 if score #cost_waiting dr_var matches 1.. run return run function derailed:dev/gen/_cost_wave

# Nothing left on this level, so the rock the flood came up against is next
execute if score #cost_next dr_var matches 1.. run function derailed:dev/gen/_cost_level
