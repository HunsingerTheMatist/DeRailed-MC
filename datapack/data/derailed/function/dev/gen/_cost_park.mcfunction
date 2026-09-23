
# Parks a rock tile the flood has come up against, to be stepped onto on the
#  level after this one at the wave it was reached on, which is what costing a
#  thousand comes to when a level is worth a thousand
# Positioned on the tile

execute summon marker run function derailed:dev/gen/_cost_parked
scoreboard players add #cost_next dr_var 1
