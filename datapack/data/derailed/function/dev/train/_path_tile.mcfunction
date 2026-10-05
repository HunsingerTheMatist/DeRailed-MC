
# Adds the tile '#tx' '#tz' blocks from the track's corner to the end of the
#  path: its middle, in thousandths of a block, its ways in and out, '#din'
#  and '#dout', and its length, 3000 straight or 2356 round a corner

data modify storage derailed:train new set value {x:0,z:0,din:0,dout:0,len:3000}
scoreboard players operation #t dr_temp = #ox dr_temp
scoreboard players operation #t dr_temp += #tx dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train new.x int 1 run scoreboard players add #t dr_temp 1500
scoreboard players operation #t dr_temp = #oz dr_temp
scoreboard players operation #t dr_temp += #tz dr_temp
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train new.z int 1 run scoreboard players add #t dr_temp 1500
execute store result storage derailed:train new.din int 1 run scoreboard players get #din dr_temp
execute store result storage derailed:train new.dout int 1 run scoreboard players get #dout dr_temp
execute unless score #din dr_temp = #dout dr_temp run data modify storage derailed:train new.len set value 2356
data modify storage derailed:train path append from storage derailed:train new
