
# Sets up both benchmarks: the objective the wave loop schedules on, and an area
#  that stays loaded so a run measures the work and nothing else

scoreboard objectives add dr_wave dummy "DeRailed Bench Wave"

function derailed:dev/idmap/load

execute in derailed:game run forceload add 999 -1 1144 16

# The limit a chain runs under is fixed when the chain starts, so raising it
#  inside 'dev/bench/run' does nothing for that run
gamerule max_command_sequence_length 2000000
