
# Moves this player out from under the barriers over the train's rails, where
#  a corner of where they stand has one a block above their feet and they reach
#  under the barrier itself: across the way it runs, to whichever side they
#  already stand on, since under it is room enough to crawl
# Run as the player, at them

scoreboard players set #pt dr_temp 0
execute if score #pt dr_temp matches 0 positioned ~0.29 ~1 ~0.29 if block ~ ~ ~ pink_stained_glass_pane[east=true] run function derailed:train/_pane_hit {t:1,x:290,z:290}
execute if score #pt dr_temp matches 0 positioned ~0.29 ~1 ~0.29 if block ~ ~ ~ pink_stained_glass_pane[north=true] run function derailed:train/_pane_hit {t:2,x:290,z:290}
execute if score #pt dr_temp matches 0 positioned ~0.29 ~1 ~-0.29 if block ~ ~ ~ pink_stained_glass_pane[east=true] run function derailed:train/_pane_hit {t:1,x:290,z:-290}
execute if score #pt dr_temp matches 0 positioned ~0.29 ~1 ~-0.29 if block ~ ~ ~ pink_stained_glass_pane[north=true] run function derailed:train/_pane_hit {t:2,x:290,z:-290}
execute if score #pt dr_temp matches 0 positioned ~-0.29 ~1 ~0.29 if block ~ ~ ~ pink_stained_glass_pane[east=true] run function derailed:train/_pane_hit {t:1,x:-290,z:290}
execute if score #pt dr_temp matches 0 positioned ~-0.29 ~1 ~0.29 if block ~ ~ ~ pink_stained_glass_pane[north=true] run function derailed:train/_pane_hit {t:2,x:-290,z:290}
execute if score #pt dr_temp matches 0 positioned ~-0.29 ~1 ~-0.29 if block ~ ~ ~ pink_stained_glass_pane[east=true] run function derailed:train/_pane_hit {t:1,x:-290,z:-290}
execute if score #pt dr_temp matches 0 positioned ~-0.29 ~1 ~-0.29 if block ~ ~ ~ pink_stained_glass_pane[north=true] run function derailed:train/_pane_hit {t:2,x:-290,z:-290}
execute if score #pt dr_temp matches 0 run return 0

execute store result score #px dr_temp run data get entity @s Pos[0] 1000
execute store result score #pz dr_temp run data get entity @s Pos[2] 1000
execute if score #pt dr_temp matches 1 run function derailed:train/_pane_z
execute if score #pt dr_temp matches 2 run function derailed:train/_pane_x
execute if score #pt dr_temp matches 0 run return 0
function derailed:train/_push_to
