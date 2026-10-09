# A broken block of a tile left its seed. Run as the seed, at the seed
#
# A tile's blocks drop a seed rather than loot, since nothing reports a broken
#  block to a datapack directly. The seed lands in the block it came from, and
#  the tile's mining marker stands at the tile's northwestern block two below
#  the ground, so it is the one marker under the three by three columns that
#  reach down from here. The seed is a signal rather than loot, so it is
#  destroyed

execute align xyz positioned ~-2.5 ~-9.5 ~-2.5 as @n[type=marker,tag=dr_mine,dx=2,dy=9,dz=2] at @s run function derailed:mine/advance

# The next stage's block stands where the broken one was, and a client takes
#  the same place with the same item in hand as the block it was already
#  breaking, so it never tells the server it started on it and the server plays
#  none of its mining sounds; a change to the item in the hand of the player who
#  broke it makes it a new block to them
execute as @a[distance=..8,scores={dr_tool_used=1..}] run function derailed:item/event/_nudge_held
kill @s
