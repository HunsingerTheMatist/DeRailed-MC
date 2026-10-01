
# Sets up both benchmarks: the objective the wave loop schedules on, and an area
#  that stays loaded so a run measures the work and nothing else

scoreboard objectives add dr_wave dummy "DeRailed Bench Wave"

function derailed:dev/idmap/load

execute in derailed:game run forceload add 999 -1 1096 16

# Where 'dev/big/build' builds a section's large version
execute in derailed:game run forceload add 1099 -1 1196 48

# The copy of it 'station/merge' works on, 64 blocks south
execute in derailed:game run forceload add 1099 63 1196 112

# The limit a chain runs under is fixed when the chain starts, so raising it
#  inside 'dev/bench/run' does nothing for that run
gamerule max_command_sequence_length 10000000
