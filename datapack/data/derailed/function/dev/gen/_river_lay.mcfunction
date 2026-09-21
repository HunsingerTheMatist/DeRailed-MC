
# Lays a river tile where the head now stands and carries on from there
# Run as the head, positioned on it

execute summon marker run function derailed:dev/gen/_river_lay_set
scoreboard players add #riv_len dr_var 1
scoreboard players add #riv_step dr_var 1

function derailed:dev/gen/_river_run
