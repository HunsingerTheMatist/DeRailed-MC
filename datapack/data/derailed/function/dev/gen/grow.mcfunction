
# Grows every seed at once until the section is full
# Positioned at the section's corner

# Nothing a growth before this one left due to spread or waiting on a wave
#  carries into it
function derailed:dev/gen/_kill_waves
kill @e[type=marker,tag=dr_seam_wait,distance=0..]

# Unclaimed ground, which is also what stops growth at the section edge
fill ~ ~ ~ ~31 ~ ~15 black_concrete strict

# The station and the pieces stand where nothing grows, so they go back over
#  the fill
execute if score #gen_station dr_var matches 1 run function derailed:dev/gen/_station_stamp with storage derailed:gen r
function derailed:dev/gen/_pieces_stamp

# How many tiles are due to spread and how many are waiting on a carried region,
#  kept as counts so the wave loop never has to go looking for them
scoreboard players set #gen_pending dr_var 0
scoreboard players set #gen_waiting dr_var 0

# How many tiles the regions carried over the seam take, by kind, which the
#  kinds charge their draw for
scoreboard players set #bleed_ground dr_var 0
scoreboard players set #bleed_wood dr_var 0
scoreboard players set #bleed_iron dr_var 0
scoreboard players set #bleed_water dr_var 0
scoreboard players set #bleed_rock dr_var 0

execute as @e[type=marker,tag=dr_seed,distance=0..] at @s run function derailed:dev/gen/_seed_claim
function derailed:dev/gen/seam

scoreboard players set #gen_wave dr_var 0
function derailed:dev/gen/_wave
