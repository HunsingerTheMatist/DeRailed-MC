
# Runs a band of rock from the north border to the south, seed to seed, so that
#  the cheapest way across has to cut through it
# Every region the band passes through on its way from one seed to the next goes
#  on it with them, so there is no gap between two of its regions for the route
#  to slip through, and it reaches both borders
# Positioned at the section's corner, once the regions have grown

execute summon marker run function derailed:dev/gen/_read_corner

# A band that ran through a region carried over the seam is laid again from
#  another column, a few times over
scoreboard players set #wall_tries dr_var 4
function derailed:dev/gen/_wall_try
