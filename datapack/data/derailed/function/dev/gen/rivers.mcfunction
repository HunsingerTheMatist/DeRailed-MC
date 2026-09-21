
# Cuts a river along the boundaries between regions
# A section that took one over the seam and got barely anywhere with it gets a
#  second search of its own on top
# Positioned at the section's corner

function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_seed,distance=0..]

# The river is cut into a copy of what it reads, so nothing it lays can change the
#  answer to a later look
clone ~ ~5 ~ ~47 ~5 ~15 ~ ~9 ~ strict

# What the section before handed over, taken now so that this section's own
#  handing over does not write over it
scoreboard players operation #riv_carry dr_var = #riv_hand dr_var
scoreboard players operation #riv_carry_row dr_var = #riv_hand_row dr_var
scoreboard players set #riv_hand dr_var 0

scoreboard players set #riv_done dr_var 0
scoreboard players set #riv_len dr_var 0
scoreboard players set #riv_dead dr_var 0
scoreboard players set #riv_depth dr_var 0
scoreboard players set #riv_forced dr_var 0
scoreboard players set #riv_best dr_var 0
scoreboard players set #riv_short dr_var 0

# Walks are cheap to start and dear to finish, so misses get their own budget and
#  the whole search shares one count of steps
scoreboard players set #riv_tries dr_var 8
scoreboard players set #riv_rolls dr_var 200
scoreboard players set #riv_steps dr_var 1000

function derailed:dev/gen/_river_try
execute if score #riv_short dr_var matches 1 run function derailed:dev/gen/_river_second

# The search leaves its markers standing whether it got anywhere or not
# Holding them leaves the corners the walk ran over there to be read, which the
#  water cannot be read back as: a corner and the tile it wets are not the same
#  place
execute if score #gen_riv_hold dr_var matches 1 run return 0
function derailed:dev/gen/_river_wipe
kill @e[type=marker,tag=dr_riv_seed,distance=0..]
