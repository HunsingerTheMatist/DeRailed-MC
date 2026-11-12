
# Has every river run from north to south: each river is followed from a tile
#  nothing flows into down to where it leaves the map, meets a lake or meets a
#  river already followed, the longest first, and where that stretch ends
#  further north than it starts it flows the other way, each of its tiles
#  toward the one before it
# The way each river tile flows is kept in 'dr_bdir' meanwhile, 0 north, 1
#  east, 2 south and 3 west, as it flowed before, -1 for none
# Run in the game's dimension, before the bends are worked out

scoreboard players set @e[type=marker,tag=dr_big_river,distance=0..] dr_bdir -1
scoreboard players set @e[type=marker,tag=dr_big_river,tag=dr_big_n,distance=0..] dr_bdir 0
scoreboard players set @e[type=marker,tag=dr_big_river,tag=dr_big_e,distance=0..] dr_bdir 1
scoreboard players set @e[type=marker,tag=dr_big_river,tag=dr_big_s,distance=0..] dr_bdir 2
scoreboard players set @e[type=marker,tag=dr_big_river,tag=dr_big_w,distance=0..] dr_bdir 3
execute as @e[type=marker,tag=dr_big_river,distance=0..] at @s run function derailed:dev/big/_south_feeds
execute as @e[type=marker,tag=dr_big_river,tag=!dr_big_fed,distance=0..] at @s run function derailed:dev/big/_south_measure
function derailed:dev/big/_south_next

tag @e[type=marker,tag=dr_big_fed,distance=0..] remove dr_big_fed
tag @e[type=marker,tag=dr_big_done,distance=0..] remove dr_big_done
tag @e[type=marker,tag=dr_big_src_done,distance=0..] remove dr_big_src_done
