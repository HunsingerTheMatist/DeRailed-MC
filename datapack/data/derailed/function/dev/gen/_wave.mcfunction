
# Wakes everything due on this wave, then moves on to the next

# What the next claims will be tagged with, and what this wave's own is, which a
#  tile waking from the seam needs so that it spreads from here rather than a
#  wave later
scoreboard players operation #gen_w5 dr_var = #gen_wave dr_var
scoreboard players add #gen_w5 dr_var 5
scoreboard players operation #gen_w5 dr_var %= $Eight dr_const
execute store result storage derailed:gen a5.w int 1 run scoreboard players get #gen_w5 dr_var

scoreboard players operation #gen_w7 dr_var = #gen_wave dr_var
scoreboard players add #gen_w7 dr_var 7
scoreboard players operation #gen_w7 dr_var %= $Eight dr_const
execute store result storage derailed:gen a7.w int 1 run scoreboard players get #gen_w7 dr_var

scoreboard players operation #gen_mod dr_var = #gen_wave dr_var
scoreboard players operation #gen_mod dr_var %= $Eight dr_const
execute store result storage derailed:gen a0.w int 1 run scoreboard players get #gen_mod dr_var

# A tile carried over the seam waits on a score rather than a tag, since its
#  region may still be many waves off
# Woken before anything is handed out this wave, because arriving now is cheaper
#  than any claim this wave could make on it
# Looked for only while any are left, since the sweep costs as much as a hundred
#  block tests and most waves have none to find
# The sweeps here are left unbounded on purpose: boxing them to the section was
#  measured slower, since at a few hundred entities a box test on each costs more
#  than a straight pass with a tag check
execute if score #gen_waiting dr_var matches 1.. as @e[type=marker,tag=dr_seam_wait,distance=0..] if score @s dr_wake = #gen_wave dr_var at @s run function derailed:dev/gen/_seam_wake with storage derailed:gen a0

# Every straight step in a wave is taken before any diagonal one
# Claiming happens when a tile is handed out rather than when it wakes, so
#  whichever marker the wave reaches first takes it: without the split a marker's
#  diagonal reaches a tile ahead of its neighbour's straight step, and a boundary
#  between two regions is dragged a row sideways for every column it crosses

execute if score #gen_mod dr_var matches 0 as @e[type=marker,tag=dr_w0,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 1 as @e[type=marker,tag=dr_w1,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 2 as @e[type=marker,tag=dr_w2,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 3 as @e[type=marker,tag=dr_w3,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 4 as @e[type=marker,tag=dr_w4,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 5 as @e[type=marker,tag=dr_w5,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 6 as @e[type=marker,tag=dr_w6,distance=0..] at @s run function derailed:dev/gen/_activate5
execute if score #gen_mod dr_var matches 7 as @e[type=marker,tag=dr_w7,distance=0..] at @s run function derailed:dev/gen/_activate5

execute if score #gen_mod dr_var matches 0 as @e[type=marker,tag=dr_w0,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 1 as @e[type=marker,tag=dr_w1,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 2 as @e[type=marker,tag=dr_w2,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 3 as @e[type=marker,tag=dr_w3,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 4 as @e[type=marker,tag=dr_w4,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 5 as @e[type=marker,tag=dr_w5,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 6 as @e[type=marker,tag=dr_w6,distance=0..] at @s run function derailed:dev/gen/_activate7
execute if score #gen_mod dr_var matches 7 as @e[type=marker,tag=dr_w7,distance=0..] at @s run function derailed:dev/gen/_activate7

scoreboard players add #gen_wave dr_var 1

# Tiles still waiting on a carried region keep the loop alive as much as pending
#  ones do, since their own wave may be a long way off yet
execute if score #gen_wave dr_var matches ..400 if score #gen_pending dr_var matches 1.. run return run function derailed:dev/gen/_wave
execute if score #gen_wave dr_var matches ..400 if score #gen_waiting dr_var matches 1.. run function derailed:dev/gen/_wave
