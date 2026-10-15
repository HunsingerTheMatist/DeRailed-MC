# Goes on along the aim a tenth of a block at a time, as far as 4.5 blocks, the
#  reach for blocks and entities alike: an interaction or another player here
#  takes the click, so nothing shows; otherwise the first block met is clicked,
#  the block a step back where it has collision and the block itself where it
#  has none, like a flower
# Blocks are tested whole, so a pile's cakes, narrower than their blocks, are
#  passed through to the pile's interaction round them, and a slab only stops
#  the aim in its full half
# Run at a point on the aim, facing along it

execute positioned ~-0.995 ~-0.995 ~-0.995 as @e[type=interaction,dx=0,dy=0,dz=0] positioned ~0.99 ~0.99 ~0.99 if entity @s[dx=0,dy=0,dz=0] run return 0
execute positioned ~-0.995 ~-0.995 ~-0.995 as @a[tag=!dr_ray_self,dx=0,dy=0,dz=0] positioned ~0.99 ~0.99 ~0.99 if entity @s[dx=0,dy=0,dz=0] run return 0

# A point is in a bottom slab's empty top half where half a block up from it is
#  out of the slab's block, and in a top slab's empty bottom half where half a
#  block down is
scoreboard players set #ray_solid dr_temp 0
execute unless block ~ ~ ~ #derailed:ray_passable run scoreboard players set #ray_solid dr_temp 1
execute if block ~ ~ ~ #minecraft:slabs[type=bottom] positioned ~ ~0.5 ~ unless block ~ ~ ~ #minecraft:slabs[type=bottom] run scoreboard players set #ray_solid dr_temp 0
execute if block ~ ~ ~ #minecraft:slabs[type=top] positioned ~ ~-0.5 ~ unless block ~ ~ ~ #minecraft:slabs[type=top] run scoreboard players set #ray_solid dr_temp 0
execute if score #ray_solid dr_temp matches 1 if block ~ ~ ~ #derailed:pile_replaceable run return run function derailed:track/_ghost_at
execute if score #ray_solid dr_temp matches 1 positioned ^ ^ ^-0.1 run return run function derailed:track/_ghost_at

scoreboard players add #ray_steps dr_temp 1
execute if score #ray_steps dr_temp matches 46.. run return 0
execute positioned ^ ^ ^0.1 run return run function derailed:track/_ghost_step
