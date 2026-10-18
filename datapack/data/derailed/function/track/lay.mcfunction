# Lays a rail on the tile ahead of the end of the track: turns the end's rails
#  toward it where '#curve' says, lays its rails straight on, curves the end's
#  tile of the train's path to match and adds the new one to it, makes the new
#  tile the end and takes a rail off the player
# Axles on the end's tile are moved onto its new line where they are, and roll
#  on to the new tile next tick where they are further in than its new length
# Run as the player, at the middle of the end of the track's middle block,
#  facing the way on, with the way it came in by in '#din' and the way on in
#  '#d'

execute if score #curve dr_temp matches 1 run fill ~-1 ~ ~ ~1 ~ ~ air replace iron_trapdoor strict
execute if score #curve dr_temp matches 1 run fill ~ ~ ~-1 ~ ~ ~1 air replace iron_trapdoor strict
scoreboard players operation #dout dr_temp = #d dr_temp
execute if score #curve dr_temp matches 1 positioned ~-1 ~ ~-1 run function derailed:track/lay_rails
scoreboard players operation #din dr_temp = #d dr_temp
execute positioned ^ ^ ^3 positioned ~-1 ~ ~-1 run function derailed:track/lay_rails

# Every ghost stood for a rail laid beside the old end, so none is right any
#  more; the next ghost tick shows those the new end's tiles call for
kill @e[type=item_display,tag=dr_rail_ghost,distance=0..]

execute store result score #last dr_temp run data get storage derailed:train path
scoreboard players remove #last dr_temp 1
execute store result storage derailed:train path[-1].dout int 1 run scoreboard players get #d dr_temp
execute if score #curve dr_temp matches 1 run data modify storage derailed:train path[-1].len set value 2356

# The end moves onto the new tile's middle block, snapped to its middle
execute as @n[type=marker,tag=dr_track_end,distance=0..] at @s rotated as @s run tp @s ^ ^ ^3
execute as @n[type=marker,tag=dr_track_end,distance=0..] at @s align xyz positioned ~0.5 ~0.5 ~0.5 run tp @s ~ ~ ~
data modify storage derailed:track rails append from entity @n[type=marker,tag=dr_track_end,distance=0..] Pos

data modify storage derailed:train new set value {x:0,z:0,din:0,dout:0,len:3000}
execute store result storage derailed:train new.x int 1 run data get entity @n[type=marker,tag=dr_track_end,distance=0..] Pos[0] 1000
execute store result storage derailed:train new.z int 1 run data get entity @n[type=marker,tag=dr_track_end,distance=0..] Pos[2] 1000
execute store result storage derailed:train new.din int 1 run scoreboard players get #d dr_temp
execute store result storage derailed:train new.dout int 1 run scoreboard players get #d dr_temp
data modify storage derailed:train path append from storage derailed:train new

execute as @e[type=marker,tag=dr_axle,distance=0..] if score @s dr_ai = #last dr_temp run function derailed:train/_axle_load

scoreboard players set #curr_item_count dr_arg 1
function derailed:player/take_items
