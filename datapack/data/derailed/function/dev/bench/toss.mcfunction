# Times thrown piles in flight: throws 20 single wood piles out level in a ring,
#  every 18 degrees, from 25 blocks above the player, where nothing is near,
#  then moves every one of them 10 ticks' worth with 'toss/_fly', 200 moves in
#  all, without taking anything off the player
# The whole run happens in one tick, so profile the tick this is called on
# Run as a player in the game

# 'dev/bench/toss_stop' clears up and lets the game tick run again on the tick
#  after, and scheduling it first means it still runs if the chain is cut short
schedule function derailed:dev/bench/toss_stop 1t
scoreboard players set #bench dr_var 1

scoreboard players operation #curr_item dr_arg = $Wood dr_const
scoreboard players set #curr_item_count dr_arg 1
scoreboard players operation #curr_player_id dr_arg = @s dr_player_id
scoreboard players set #curr_rotation dr_arg 0
execute at @s positioned ~ ~25 ~ rotated 0 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 18 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 36 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 54 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 72 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 90 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 108 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 126 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 144 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 162 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 180 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 198 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 216 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 234 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 252 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 270 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 288 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 306 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 324 0 run function derailed:dev/bench/_toss_one
execute at @s positioned ~ ~25 ~ rotated 342 0 run function derailed:dev/bench/_toss_one

function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
function derailed:dev/bench/_toss_step
