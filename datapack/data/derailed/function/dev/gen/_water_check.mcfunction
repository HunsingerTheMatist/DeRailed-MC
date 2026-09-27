
# Counts how many tiles of the cheapest way across lie further than
#  '#gen_water_reach' steps from water, into '#water_far', out of '#water_path'
# The steps are walked north, south, east and west over land, rock and the
#  station's building standing in the way, and water in the section before
#  counts as well as this section's own
# Positioned at the section's corner, on the visible layer, with the routes
#  drawn two above and the cheapest way marked 'dr_cp' where it is not the
#  first route

# Where the cheapest way across is the first route, it is marked from that
execute unless entity @e[type=marker,tag=dr_cp,distance=0..] run function derailed:dev/gen/_water_path

# How far west the search may look: as far back as the reach, into the section
#  before, or not past this section's own edge where there is none
execute store result storage derailed:gen w.xs int -1 run scoreboard players get #gen_water_reach dr_var
execute if score #gen_section dr_var matches 0 run data modify storage derailed:gen w.xs set value 0
execute store result score #wr_x dr_var run data get storage derailed:gen w.xs
execute store result storage derailed:gen w.xw int 1 run scoreboard players remove #wr_x dr_var 1
function derailed:dev/gen/_water_area with storage derailed:gen w

scoreboard players set #water_path dr_var 0
scoreboard players set #water_far dr_var 0
execute store result score #water_path dr_var if entity @e[type=marker,tag=dr_cp,distance=0..]
execute as @e[type=marker,tag=dr_cp,distance=0..] at @s if block ~ ~-1 ~ air run scoreboard players add #water_far dr_var 1

function derailed:dev/gen/_water_clear with storage derailed:gen w
kill @e[type=marker,tag=dr_cp,distance=0..]
