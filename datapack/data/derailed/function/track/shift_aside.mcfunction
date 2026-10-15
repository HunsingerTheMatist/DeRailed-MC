# Moves every placement tagged 'dr_shift' aside onto a spot round it, whole, as
#  dropping its items there would: first as a plan in scores alone, with the
#  spots it would take reserved and the blocks the rail takes barred, then for
#  real once every one of them has somewhere to go, and otherwise not at all
# Run at the middle of the end of the track's middle block, facing the way on
#
# Returns 1 when all of them moved, fail otherwise

# The rail's blocks are barred by placements no item can go on, at their middles
#  so they are found ahead of the placements standing there
execute positioned ^ ^ ^2 run summon interaction ~ ~ ~ {Tags:["dr_placement","dr_shift_bar"],width:0f,height:0f}
execute positioned ^ ^ ^3 run summon interaction ~ ~ ~ {Tags:["dr_placement","dr_shift_bar"],width:0f,height:0f}
execute positioned ^ ^ ^4 run summon interaction ~ ~ ~ {Tags:["dr_placement","dr_shift_bar"],width:0f,height:0f}
execute if score #curve dr_temp matches 1 positioned ^ ^ ^1 run summon interaction ~ ~ ~ {Tags:["dr_placement","dr_shift_bar"],width:0f,height:0f}

scoreboard players set #shifting dr_temp 1
scoreboard players set #shift_failed dr_temp 0
execute as @e[type=interaction,tag=dr_shift,distance=0..] at @s align xyz positioned ~0.5 ~ ~0.5 run function derailed:track/_shift_one
scoreboard players set #shifting dr_temp 0

# Carried out, the placements moved aside empty and the spots they went to are
#  drawn; given up, what was added to piles comes off and the reserved spots go
execute if score #shift_failed dr_temp matches 0 as @e[type=interaction,tag=dr_shift,distance=0..] at @s run function derailed:track/_shift_empty
execute if score #shift_failed dr_temp matches 0 as @e[type=interaction,tag=dr_reserved,distance=0..] at @s run function derailed:track/_shift_draw
execute if score #shift_failed dr_temp matches 0 as @e[type=marker,tag=dr_shift_to,distance=0..] at @s as @n[type=interaction,tag=dr_placement,distance=..0.01] at @s run function derailed:track/_shift_draw
execute if score #shift_failed dr_temp matches 1 as @e[type=marker,tag=dr_shift_to,distance=0..] at @s run function derailed:track/_shift_unmove
execute if score #shift_failed dr_temp matches 1 run kill @e[type=interaction,tag=dr_reserved,distance=0..]

kill @e[type=interaction,tag=dr_shift_bar,distance=0..]
kill @e[type=marker,tag=dr_shift_to,distance=0..]
tag @e[type=interaction,tag=dr_shift,distance=0..] remove dr_shift
execute if score #shift_failed dr_temp matches 1 run return fail
return 1
