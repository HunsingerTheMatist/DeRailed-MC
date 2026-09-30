
# Ends an attempt: judges the windows and the water, then sends the section
#  on to be finished where it passes, and otherwise to another attempt, to the
#  wall and rivers laid again first, or to a fresh start
# Positioned at the section's corner

# A section that leaves more windows wanting than it is let off, or any far
#  short, is a reroll while '#gen_window_reroll' says so
execute if score #gen_window_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #gen_spread_fail dr_var matches 1 run scoreboard players add #gen_fail_windows dr_var 1
execute if score #gen_window_reroll dr_var matches 1 if score #gen_spread_fail dr_var matches 1 run scoreboard players set #gen_valid dr_var 0

# Then every tile of the cheapest way across has to have water within
#  '#gen_water_reach' steps, on the section as it ships, and one that does not
#  is a reroll while '#gen_water_reroll' says so
execute if score #gen_valid dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_water_check
execute if score #gen_water_reroll dr_var matches 1 if score #gen_valid dr_var matches 1 if score #water_far dr_var matches 1.. run scoreboard players add #gen_fail_water dr_var 1
execute if score #gen_water_reroll dr_var matches 1 if score #water_far dr_var matches 1.. run scoreboard players set #gen_valid dr_var 0
execute if score #gen_valid dr_var matches 1 run scoreboard players set #q_step dr_var 20
execute if score #gen_valid dr_var matches 1 run return 1

# Counted as a reroll only where another attempt follows, on these regions or
#  laid afresh; the section's last attempt ships as it is
scoreboard players remove #gen_attempts dr_var 1
execute if score #gen_attempts dr_var matches 1.. run scoreboard players add #gen_rerolls dr_var 1
execute if score #gen_attempts dr_var matches ..0 if score #gen_fresh_left dr_var matches 1.. run scoreboard players add #gen_rerolls dr_var 1

# A section that has found no second way twice is built again from its regions
#  as they grew for every attempt after, wall, rivers and all, since drawing the
#  kinds again leaves those as they are, and on hard the wall's rock is mostly
#  what stands in the second way's way
execute if score #sec_ran dr_var matches 1 if score #sec_reached dr_var matches 0 run scoreboard players add #gen_second_misses dr_var 1
execute if score #gen_attempts dr_var matches 1.. if score #gen_second_misses dr_var matches 2.. run return run scoreboard players set #q_step dr_var 17

# Painting swaps each region's own block for the kind it rolled, so going again
#  means laying the regions out afresh to have something left to swap
# The first attempt paints straight onto what the section was left standing as,
#  which is why this is here rather than at the head of an attempt
execute if score #gen_attempts dr_var matches 1.. run clone ~ ~ ~ ~31 ~ ~15 ~ ~5 ~ strict
execute if score #gen_attempts dr_var matches 1.. run return run scoreboard players set #q_step dr_var 10

# Out of attempts on these regions, the section is thrown out and laid again
#  from new seeds while fresh starts are left, and ships as it is after that
execute if score #gen_fresh_left dr_var matches 1.. run return run scoreboard players set #q_step dr_var 18
scoreboard players add #gen_failed dr_var 1
scoreboard players set #q_step dr_var 20
return 1
