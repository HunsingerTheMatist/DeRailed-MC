
# Grows every seed at once until the section is full
# Positioned at the section's corner

# Unclaimed ground, which is also what stops growth at the section edge
fill ~ ~ ~ ~47 ~ ~15 black_concrete strict

# How many tiles are due to spread and how many are waiting on a carried region,
#  kept as counts so the wave loop never has to go looking for them
scoreboard players set #gen_pending dr_var 0
scoreboard players set #gen_waiting dr_var 0

execute as @e[type=marker,tag=dr_seed,distance=0..] at @s run function derailed:dev/gen/_seed_claim
function derailed:dev/gen/seam

scoreboard players set #gen_wave dr_var 0
function derailed:dev/gen/_wave
