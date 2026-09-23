
# Runs a band of rock from the north border to the south, seed to seed, so that
#  the cheapest way across has to cut through it
# Positioned at the section's corner

execute summon marker run function derailed:dev/gen/_read_corner

# The band starts at the seed nearest a random point on the north border and
#  steps south from there, a few rows at a time so that it cannot jump a seed
#  and leave a gap
execute store result storage derailed:gen w.x int 1 run random value 2..29
scoreboard players set #gen_steps dr_var 8
function derailed:dev/gen/_wall_start with storage derailed:gen w
