
# Lays the rails of the tile $(x) $(z) blocks from the track's corner, coming
#  in going way $(din) and leaving going way $(dout), with a track tile marker
#  of team '#train_team' in the middle of its middle block, and adds it to the
#  end of team $(team)'s path: its middle, in thousandths of a block, its ways
#  in and out, and its length, 3000 straight or 2356 round a corner

$scoreboard players set #din dr_temp $(din)
$scoreboard players set #dout dr_temp $(dout)
$execute positioned ~$(x) ~ ~$(z) run function derailed:track/lay_rails
$execute positioned ~$(x) ~ ~$(z) align xyz positioned ~1.5 ~0.5 ~1.5 summon marker run function derailed:dev/track/_tile

data modify storage derailed:train new set value {x:0,z:0,din:0,dout:0,len:3000}
scoreboard players operation #t dr_temp = #ox dr_temp
$scoreboard players add #t dr_temp $(x)
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train new.x int 1 run scoreboard players add #t dr_temp 1500
scoreboard players operation #t dr_temp = #oz dr_temp
$scoreboard players add #t dr_temp $(z)
scoreboard players operation #t dr_temp *= $Thousand dr_const
execute store result storage derailed:train new.z int 1 run scoreboard players add #t dr_temp 1500
$data modify storage derailed:train new.din set value $(din)
$data modify storage derailed:train new.dout set value $(dout)
execute unless score #din dr_temp = #dout dr_temp run data modify storage derailed:train new.len set value 2356
$data modify storage derailed:train t$(team).path append from storage derailed:train new
