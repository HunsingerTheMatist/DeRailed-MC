
# Moves this player to '#px' '#pz', in thousandths of a block, at the height
#  they are at, keeping the way they face
# Run as the player

execute summon marker run function derailed:train/_push_mark
data modify entity @n[type=marker,tag=dr_push_mark,distance=0..] Pos[1] set from entity @s Pos[1]
execute at @n[type=marker,tag=dr_push_mark,distance=0..] run tp @s ~ ~ ~
kill @e[type=marker,tag=dr_push_mark,distance=0..]
