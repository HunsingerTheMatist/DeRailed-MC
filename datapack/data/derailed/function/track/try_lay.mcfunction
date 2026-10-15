# Lays a rail on the tile clicked, where it is a tile beside the end of the
#  track other than the one the track came in from, and the blocks the rail
#  takes there, and the one the end's rail turns through, are open ground: sets
#  '#lay' to 1 once laid, to 2 where piles in the way could not all be moved
#  aside, and leaves it at 0 where no rail goes there, for the rail to be put
#  down as a pile instead
# Run as the player, at the bottom middle of the clicked block

execute unless data storage derailed:train path[-1] run return 0
execute unless entity @n[type=marker,tag=dr_track_end,distance=0..] run return 0

# The clicked block from the middle block of the end's tile
execute summon marker run function derailed:track/_click_pos
execute store result score #ex dr_temp run data get entity @n[type=marker,tag=dr_track_end,distance=0..] Pos[0]
execute store result score #ez dr_temp run data get entity @n[type=marker,tag=dr_track_end,distance=0..] Pos[2]
scoreboard players operation #cx dr_temp -= #ex dr_temp
scoreboard players operation #cz dr_temp -= #ez dr_temp

# The way on from the end's tile to the clicked one, 0 north, 1 east, 2 south
#  and 3 west, which turns the end's rail where it is not the way it came in
scoreboard players set #d dr_temp -1
execute if score #cz dr_temp matches -1..1 if score #cx dr_temp matches 2..4 run scoreboard players set #d dr_temp 1
execute if score #cz dr_temp matches -1..1 if score #cx dr_temp matches -4..-2 run scoreboard players set #d dr_temp 3
execute if score #cx dr_temp matches -1..1 if score #cz dr_temp matches 2..4 run scoreboard players set #d dr_temp 2
execute if score #cx dr_temp matches -1..1 if score #cz dr_temp matches -4..-2 run scoreboard players set #d dr_temp 0
execute if score #d dr_temp matches -1 run return 0
execute store result score #din dr_temp run data get storage derailed:train path[-1].din
scoreboard players operation #back dr_temp = #din dr_temp
scoreboard players add #back dr_temp 2
scoreboard players operation #back dr_temp %= $Four dr_const
execute if score #d dr_temp = #back dr_temp run return 0
scoreboard players set #curve dr_temp 0
execute unless score #d dr_temp = #din dr_temp run scoreboard players set #curve dr_temp 1

# The end faces the way on, so the blocks along it are a block apart ahead of
#  it: a facing of 0 is south and 90 west
scoreboard players operation #t dr_temp = #d dr_temp
scoreboard players operation #t dr_temp *= $RotationStep dr_const
scoreboard players add #t dr_temp 180
execute store result entity @n[type=marker,tag=dr_track_end,distance=0..] Rotation[0] float 1 run scoreboard players get #t dr_temp

tag @e[type=interaction,tag=dr_shift,distance=0..] remove dr_shift
execute at @n[type=marker,tag=dr_track_end,distance=0..] rotated as @n[type=marker,tag=dr_track_end,distance=0..] unless function derailed:track/_check run \
    return run tag @e[type=interaction,tag=dr_shift,distance=0..] remove dr_shift

execute if entity @e[type=interaction,tag=dr_shift,distance=0..] at @n[type=marker,tag=dr_track_end,distance=0..] rotated as @n[type=marker,tag=dr_track_end,distance=0..] unless function derailed:track/shift_aside run \
    return run scoreboard players set #lay dr_temp 2
execute at @n[type=marker,tag=dr_track_end,distance=0..] rotated as @n[type=marker,tag=dr_track_end,distance=0..] run function derailed:track/lay
scoreboard players set #lay dr_temp 1
