# Gives off smoke from this burning box of a train, now and then the sound of
#  fire, and marks every survival player touching it to be set on fire this
#  tick: in a box a block taller than its shulker and 0.05 out from it all round
# The smoke keeps near where any piece's fire is drawn round its box: it spreads
#  on a bell curve whose deltas are its spread, so 0.5 across keeps nearly all
#  of it within the 1.05 a wagon's fire reaches out each side, whichever way it
#  faces, and it starts at 1.8, 0.15 either way, under the 2.1 the lowest fire,
#  the supply and crafting wagons', reaches over the box's display, so it comes
#  out of the top of every fire
# Run as the box's display, at it

particle minecraft:large_smoke ~ ~1.8 ~ 0.5 0.15 0.5 0.01 1
execute if predicate {type:"minecraft:random_chance",chance:0.05} run playsound minecraft:block.fire.ambient block @a ~ ~1 ~ 1
execute positioned ~-1.3 ~ ~-1.3 as @a[gamemode=survival,dx=1.6,dy=1.9,dz=1.6] run scoreboard players set @s dr_burn 1
