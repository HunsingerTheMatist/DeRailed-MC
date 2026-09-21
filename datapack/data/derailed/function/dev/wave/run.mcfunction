
# Times 100 sections worth of wave driven growth at (1000, 0, 0) in
#  'derailed:game'
# Against 'dev/bench/run', which does the same placement in one go, the
#  difference is what the wave loop itself costs

# 'dev/bench/stop' clears up and reports on the tick after, so it stays out of
#  the measurement
# Scheduling it first means it still runs if the chain is cut short, which would
#  otherwise leave the game tick held forever
schedule function derailed:dev/bench/stop 1t

# Hold the game tick so the measurement is only this
scoreboard players set #bench dr_var 1

scoreboard players set #bench_pass dr_var 0
scoreboard players set #wave_leftover dr_var 0
scoreboard players set #wave_pass dr_var 100
execute in derailed:game run function derailed:dev/wave/_pass
