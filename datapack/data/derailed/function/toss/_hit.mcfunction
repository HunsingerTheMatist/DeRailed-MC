# What a thrown pile does when 'bs.move' finds it has hit something, by which
#  face of its box hit: its bottom, coming down, lands it, stopping it dead; its
#  top, going up, stops it rising; a side stops it going across either way, so
#  it falls
# Each sets both the velocity it keeps, 'bs.vel', and what is left of this
#  tick's move, '$move.vel', as 'bs.move' asks of a collision function
# Run as the thrown display

execute if score $move.hit_face bs.lambda matches 1 run tag @s add dr_toss_landed
execute if score $move.hit_face bs.lambda matches 1 store result score $move.vel.x bs.lambda run scoreboard players set @s bs.vel.x 0
execute if score $move.hit_face bs.lambda matches 1 store result score $move.vel.y bs.lambda run scoreboard players set @s bs.vel.y 0
execute if score $move.hit_face bs.lambda matches 1 store result score $move.vel.z bs.lambda run scoreboard players set @s bs.vel.z 0

execute if score $move.hit_face bs.lambda matches 0 store result score $move.vel.y bs.lambda run scoreboard players set @s bs.vel.y 0

execute if score $move.hit_face bs.lambda matches 2..5 store result score $move.vel.x bs.lambda run scoreboard players set @s bs.vel.x 0
execute if score $move.hit_face bs.lambda matches 2..5 store result score $move.vel.z bs.lambda run scoreboard players set @s bs.vel.z 0
