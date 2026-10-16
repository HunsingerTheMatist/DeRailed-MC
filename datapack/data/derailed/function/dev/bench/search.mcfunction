# Times 10 pile searches, 'item/_try_spots', from the block the player stands
#  in, as 'dev/bench/_search_setup' sets up
# The whole run happens in one tick, so profile the tick this is called on
# Run as a player in the game

function derailed:dev/bench/_search_setup
execute align xyz positioned ~0.5 ~ ~0.5 run function derailed:dev/bench/_search_runs
