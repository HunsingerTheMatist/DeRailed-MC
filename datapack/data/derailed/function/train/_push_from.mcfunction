
# Moves the player at '#px' '#py' '#pz' out of the shulker box this entity's
#  shulker rides in, where they are more than 0.1 into it, along x or z,
#  whichever side they are nearer, to 1.6 from its middle: half the box and half
#  a player, and 0.05 over
# The box is 2.5 across and 2.5 high, from 0.3 to 2.8 above the display, and
#  a player 0.6 across and 1.8 high, in thousandths of a block, so they touch
#  at 1.55 from its middle each way
# A player is let a little way into the box, since the box they see and walk
#  against stands where it stood a tick before
# Run as the item display the shulker rides

execute store result score #bx dr_temp run data get entity @s Pos[0] 1000
execute store result score #by dr_temp run data get entity @s Pos[1] 1000
execute store result score #bz dr_temp run data get entity @s Pos[2] 1000

scoreboard players operation #t dr_temp = #by dr_temp
scoreboard players add #t dr_temp 2800
execute if score #py dr_temp >= #t dr_temp run return 0
scoreboard players operation #t dr_temp = #py dr_temp
scoreboard players add #t dr_temp 1500
execute if score #t dr_temp <= #by dr_temp run return 0

# How far off the middle on each side, squared to compare without signs; more
#  than 0.1 in is within 1.45 of it
scoreboard players operation #dx dr_temp = #px dr_temp
scoreboard players operation #dx dr_temp -= #bx dr_temp
scoreboard players operation #qx dr_temp = #dx dr_temp
scoreboard players operation #qx dr_temp *= #dx dr_temp
execute if score #qx dr_temp matches 2102500.. run return 0
scoreboard players operation #dz dr_temp = #pz dr_temp
scoreboard players operation #dz dr_temp -= #bz dr_temp
scoreboard players operation #qz dr_temp = #dz dr_temp
scoreboard players operation #qz dr_temp *= #dz dr_temp
execute if score #qz dr_temp matches 2102500.. run return 0

execute if score #qx dr_temp >= #qz dr_temp run scoreboard players operation #px dr_temp = #bx dr_temp
execute if score #qx dr_temp >= #qz dr_temp if score #dx dr_temp matches 0.. run scoreboard players add #px dr_temp 1600
execute if score #qx dr_temp >= #qz dr_temp if score #dx dr_temp matches ..-1 run scoreboard players remove #px dr_temp 1600
execute if score #qx dr_temp < #qz dr_temp run scoreboard players operation #pz dr_temp = #bz dr_temp
execute if score #qx dr_temp < #qz dr_temp if score #dz dr_temp matches 0.. run scoreboard players add #pz dr_temp 1600
execute if score #qx dr_temp < #qz dr_temp if score #dz dr_temp matches ..-1 run scoreboard players remove #pz dr_temp 1600
scoreboard players set #pushed dr_temp 1
