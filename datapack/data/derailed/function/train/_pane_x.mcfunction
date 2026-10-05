
# Moves the player at '#px' out across x from under the barrier over their
#  corner '#pox' away, where they reach under the barrier itself, within 0.3625
#  of its block's middle, half a player and half a pane, to 0.4125 on the side
#  they stand, just clear of it; '#pt' goes to 0 where they do not reach under
# Rounds down to the block, so the middle is its start and a half

scoreboard players operation #c dr_temp = #px dr_temp
scoreboard players operation #c dr_temp += #pox dr_temp
scoreboard players operation #c dr_temp /= $Thousand dr_const
scoreboard players operation #c dr_temp *= $Thousand dr_const
scoreboard players add #c dr_temp 500
scoreboard players operation #t dr_temp = #px dr_temp
scoreboard players operation #t dr_temp -= #c dr_temp
execute unless score #t dr_temp matches -362..362 run return run scoreboard players set #pt dr_temp 0
scoreboard players operation #px dr_temp = #c dr_temp
execute if score #t dr_temp matches 0.. run scoreboard players add #px dr_temp 412
execute if score #t dr_temp matches ..-1 run scoreboard players remove #px dr_temp 412
