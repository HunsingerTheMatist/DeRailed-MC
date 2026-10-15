# Every 5 ticks, shows a ghost rail on the tile each player holding rails aims
#  at where clicking would lay a rail, one ghost a tile however many aim at it,
#  and takes away every ghost no one aims at any more
# Run in the game's dimension

scoreboard players add #ghost_tick dr_var 1
execute if score #ghost_tick dr_var matches ..4 run return 0
scoreboard players set #ghost_tick dr_var 0

tag @e[type=item_display,tag=dr_rail_ghost,distance=0..] add dr_ghost_stale
execute if entity @e[type=marker,tag=dr_track_next,distance=0..] as @a[distance=0..,scores={dr_count=1..}] if score @s dr_item = $Rail dr_const at @s anchored eyes positioned ^ ^ ^ run \
    function derailed:track/_ghost_ray
kill @e[type=item_display,tag=dr_ghost_stale,distance=0..]
