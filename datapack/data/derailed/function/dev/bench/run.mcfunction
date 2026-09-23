
# Times 100 sections worth of placement, each 512 markers and 512 blocks, at
#  (1000, 0, 0) in 'derailed:game'
# The whole run happens in one tick, so profile the tick this is called on

# 'dev/bench/stop' clears up and reports on the tick after, so it stays out of
#  the measurement
# Scheduling it first means it still runs if the chain is cut short, which would
#  otherwise leave the game tick held forever
schedule function derailed:dev/bench/stop 1t

# Hold the game tick so the measurement is only this
scoreboard players set #bench dr_var 1

scoreboard players set #wave_leftover dr_var 0
scoreboard players set #bench_pass dr_var 100
execute in derailed:game run function derailed:dev/bench/_pass
