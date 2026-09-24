
# Walks the flood's marks back from this tile to the route, counting the water
#  on the way that has no bridge yet and, with '#sup_mark' set, building one
#  on each
# Positioned on the tile

scoreboard players set #sup_new dr_var 0
scoreboard players set #gen_steps dr_var 200
function derailed:dev/gen/_supply_step
