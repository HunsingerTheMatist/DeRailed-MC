
# Lays the longest the search managed, for a section that had to pick up from the
#  one before and never found a way out
# Nothing is handed on, since this river reaches no border to hand over

scoreboard players set #riv_done dr_var 1
execute as @e[type=marker,tag=dr_riv_best,distance=0..] run tag @s add dr_riv_line
function derailed:dev/gen/_river_shorten

# A river that stops in the middle of dry ground reads as unfinished, so one of
#  the regions it ran out against is turned to water and it ends in a lake
# This has to happen while the regions are still readable, which is why what the
#  search gave up on is not shown until afterwards
execute as @n[type=marker,tag=dr_riv_end,distance=0..] at @s run function derailed:dev/gen/_river_lake
function derailed:dev/gen/_river_show

# Barely getting in off the seam leaves the section with next to no river, so it
#  is owed one of its own on top of this
# Counted in corners, of which the one the search set out from lays no water
execute if score #riv_best dr_var matches ..6 run scoreboard players set #riv_short dr_var 1
