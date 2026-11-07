# Takes the last rail of the player's team's track back into their empty hand,
#  where there is a rail before it to be the end and no part of the team's
#  train is on its tile: clears the tile, makes the tile before it the end, its
#  rail left as it lies, and moves the take interactions onto it; anything in
#  the hand, or a rail that cannot be taken, is refused, and another team's
#  take, or any for a player on no team, takes no notice of it at all
# Run as the player

data remove entity @n[type=interaction,distance=..10,tag=dr_track_take,tag=dr_current] interaction

scoreboard players operation #team dr_temp = @s dr_team
execute unless score @n[type=interaction,distance=..10,tag=dr_track_take,tag=dr_current] dr_team = #team dr_temp run return 0
execute unless score @s dr_count matches 0 run return run function derailed:item/reject

tag @e[type=marker,tag=dr_end_on,distance=0..] remove dr_end_on
execute as @e[type=marker,tag=dr_track_end,distance=0..] if score @s dr_team = #team dr_temp run tag @s add dr_end_on
execute store result storage derailed:train arg.team int 1 run scoreboard players get #team dr_temp
scoreboard players set #can dr_temp 0
execute store result score #can dr_temp run function derailed:track/_can_take with storage derailed:train arg
execute unless score #can dr_temp matches 1 run return run function derailed:item/reject

execute at @n[type=marker,tag=dr_end_on,distance=0..] run fill ~-1 ~ ~-1 ~1 ~ ~1 air replace iron_trapdoor strict
execute at @n[type=marker,tag=dr_end_on,distance=0..] run kill @e[type=marker,tag=dr_track_tile,distance=..0.5]
function derailed:track/_path_unlay with storage derailed:train arg

# The end faces the way it came into the tile taken, steps back a tile against
#  it, and holds the ways the rail of the tile it is on comes in and leaves:
#  a facing of 0 is south and 90 west
scoreboard players operation #t dr_temp = @n[type=marker,tag=dr_end_on,distance=0..] dr_adin
scoreboard players operation #t dr_temp *= $RotationStep dr_const
scoreboard players add #t dr_temp 180
execute store result entity @n[type=marker,tag=dr_end_on,distance=0..] Rotation[0] float 1 run scoreboard players get #t dr_temp
execute as @n[type=marker,tag=dr_end_on,distance=0..] at @s rotated as @s run tp @s ^ ^ ^-3
execute store result score @n[type=marker,tag=dr_end_on,distance=0..] dr_adin run data get storage derailed:train tile.din
execute store result score @n[type=marker,tag=dr_end_on,distance=0..] dr_adout run data get storage derailed:train tile.dout

kill @e[type=item_display,tag=dr_rail_ghost,distance=0..]
execute at @n[type=marker,tag=dr_end_on,distance=0..] run function derailed:track/_mark_next
function derailed:track/_place_take with storage derailed:train arg

scoreboard players operation #curr_item dr_arg = $Rail dr_const
scoreboard players set #give_count dr_arg 1
function derailed:item/give_item
