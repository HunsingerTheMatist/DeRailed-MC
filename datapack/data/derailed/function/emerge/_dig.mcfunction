# Throws up eight specks of the block underfoot round here, a quarter of what a
#  warden throws up each tick it emerges, and every fourth tick the sound of
#  that block being dug with a low rumble under it: of whichever ground it is,
#  dirt where it is none of these
# Run as the emerging zombie's display, at its feet

scoreboard players set #ground dr_temp 0
execute if block ~ ~-1 ~ grass_block run scoreboard players set #ground dr_temp 1
execute if block ~ ~-1 ~ moss_block run scoreboard players set #ground dr_temp 2
execute if block ~ ~-1 ~ podzol run scoreboard players set #ground dr_temp 3
execute if block ~ ~-1 ~ coarse_dirt run scoreboard players set #ground dr_temp 4
execute if block ~ ~-1 ~ sand run scoreboard players set #ground dr_temp 5
execute if block ~ ~-1 ~ gravel run scoreboard players set #ground dr_temp 6
execute if block ~ ~-1 ~ #minecraft:base_stone_overworld run scoreboard players set #ground dr_temp 7

execute if score #ground dr_temp matches 0 run particle block{block_state:"dirt"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 1 run particle block{block_state:"grass_block"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 2 run particle block{block_state:"moss_block"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 3 run particle block{block_state:"podzol"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 4 run particle block{block_state:"coarse_dirt"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 5 run particle block{block_state:"sand"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 6 run particle block{block_state:"gravel"} ~ ~ ~ 0.35 0 0.35 0 8
execute if score #ground dr_temp matches 7 run particle block{block_state:"stone"} ~ ~ ~ 0.35 0 0.35 0 8

scoreboard players operation #dig_tick dr_temp = @s dr_emerge
scoreboard players operation #dig_tick dr_temp %= $Four dr_const
execute unless score #dig_tick dr_temp matches 0 run return 0

# Dirt, podzol and coarse dirt break as gravel does
execute if score #ground dr_temp matches 0 run playsound minecraft:block.gravel.break block @a ~ ~ ~ 1 0.9
execute if score #ground dr_temp matches 1 run playsound minecraft:block.grass.hit block @a ~ ~ ~ 1 0.9
execute if score #ground dr_temp matches 2 run playsound minecraft:block.moss.break block @a ~ ~ ~ 1 0.9
execute if score #ground dr_temp matches 3..4 run playsound minecraft:block.gravel.break block @a ~ ~ ~ 1 0.9
execute if score #ground dr_temp matches 5 run playsound minecraft:block.sand.break block @a ~ ~ ~ 1 0.9
execute if score #ground dr_temp matches 6 run playsound minecraft:block.gravel.break block @a ~ ~ ~ 1 0.9
execute if score #ground dr_temp matches 7 run playsound minecraft:block.stone.break block @a ~ ~ ~ 1 0.9
playsound minecraft:block.rooted_dirt.hit block @a ~ ~ ~ 0.6 0.5
