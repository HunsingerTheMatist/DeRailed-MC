
# Wakes the rock parked for this wave, spreads from every tile due, then moves
#  on to the next wave, and to the next level once this one is spent
# Eight tags carry the waves: the dearest tile falls due four waves on, so a
#  tile put on a later wave never shares a tag with the wave being taken

scoreboard players operation #cost_mod dr_var = #cost_wave dr_var
scoreboard players operation #cost_mod dr_var %= $Eight dr_const

# Looked for only while any are parked for this level, since the sweep costs as
#  much as a hundred block tests
execute if score #cost_waiting dr_var matches 1.. as @e[type=marker,tag=dr_rock_wait,distance=0..] if score @s dr_level = #cost_level dr_var if score @s dr_wave = #cost_wave dr_var at @s run function derailed:dev/gen/_cost_wake

function derailed:dev/gen/_cost_sweep

# The second route's flood and the supply check's have tiles that cost
#  nothing, which fall due on the wave that reached them, so that wave is gone
#  round again until none is left
execute if score #cost_mode dr_var matches 1.. run function derailed:dev/gen/_cost_sweep_more

scoreboard players add #cost_wave dr_var 1

# Reaching the exit ends it, since nothing taken later could get there for less
execute if score #gen_reached dr_var matches 1 run return 0
execute if score #cost_wave dr_var matches ..400 if score #cost_pending dr_var matches 1.. run return run function derailed:dev/gen/_cost_wave
execute if score #cost_wave dr_var matches ..400 if score #cost_waiting dr_var matches 1.. run return run function derailed:dev/gen/_cost_wave

# Nothing left on this level, so the rock the flood came up against is next
execute if score #cost_next dr_var matches 1.. run function derailed:dev/gen/_cost_level
