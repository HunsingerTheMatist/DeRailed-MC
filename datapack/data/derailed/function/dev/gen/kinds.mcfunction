
# Gives every seed its kind, then makes sure the section has enough to build with
# Positioned at the section's corner

execute as @e[type=marker,tag=dr_seed,distance=0..] run function derailed:dev/gen/_roll_kind

# Drawing per seed makes a section lumpy: with two dozen seeds it can easily roll
#  only one patch of wood, so the thin kinds are topped up out of ground rather
#  than the section being thrown away
# Four wood, four iron, four rock and two water is fourteen of the twenty four,
#  which holds the cost of getting across up as well as keeping it stocked
# Rock draws first because it is the only one that cannot take just any ground
#  seed: the seeds the track runs through are shut out of it. The others would
#  otherwise be free to spend the seeds rock needs and leave it only those
scoreboard players set #gen_tries dr_var 6
function derailed:dev/gen/_top_rock

scoreboard players set #gen_tries dr_var 6
function derailed:dev/gen/_top_wood
scoreboard players set #gen_tries dr_var 6
function derailed:dev/gen/_top_iron
scoreboard players set #gen_tries dr_var 6
function derailed:dev/gen/_top_water
