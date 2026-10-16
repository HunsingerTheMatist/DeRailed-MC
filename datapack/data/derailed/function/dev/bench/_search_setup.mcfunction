# Sets a pile search bench going from the block the player stands in: lets
#  'dev/bench/search_stop' run the tick after, holds the game tick so the
#  measurement is only the searches, refuses every spot once it passes the
#  block tests so each search tries every line, and works out the map's reach
#  from there
# Run as a player in the game

# Scheduling the stop first means it still runs if the chain is cut short
schedule function derailed:dev/bench/search_stop 1t
scoreboard players set #bench dr_var 1
scoreboard players set #bench_search dr_var 1

execute align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/_search_window
scoreboard players set #piles_near dr_temp 0
scoreboard players set #search_left dr_temp 1
scoreboard players operation #curr_item dr_arg = $Wood dr_const
