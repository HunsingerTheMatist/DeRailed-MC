
# Builds mounds of kind $(kind), 'iron' or 'rock', from a map of tiles, three
#  blocks to a tile: every tile of $(block) in the $(w) by $(h) area from $(sx)
#  $(sy) $(sz) becomes a mound of columns on the area from $(dx) $(dy) $(dz),
#  lowest at the edge of its region and highest furthest in
# Every tile of iron has its three by three blocks cleared first, as high as the
#  tallest column the mound can have, and nothing else is touched
# Takes $(kind), $(sx), $(sy), $(sz), $(w), $(h), $(dx), $(dy), $(dz) and
#  $(block)
# Run in the dimension the map and the mounds are in

scoreboard objectives add dr_mi dummy "DeRailed Mound Iron"
scoreboard objectives add dr_md dummy "DeRailed Mound Depth"
scoreboard objectives add dr_mh dummy "DeRailed Mound Height"
scoreboard objectives add dr_mx dummy "DeRailed Mound Column"
scoreboard objectives add dr_mz dummy "DeRailed Mound Row"
function derailed:dev/mound/_config
$data modify storage derailed:mound cfg set from storage derailed:mound kinds.$(kind)

kill @e[type=marker,tag=dr_mt,distance=0..]
kill @e[type=marker,tag=dr_mc,distance=0..]

$data modify storage derailed:mound a set value {block:"$(block)"}
$scoreboard players set #mw dr_var $(w)
$scoreboard players set #mhh dr_var $(h)
$scoreboard players set #mdx dr_var $(dx)
$scoreboard players set #mdy dr_var $(dy)
$scoreboard players set #mdz dr_var $(dz)
scoreboard players set #m3 dr_var 3
scoreboard players set #m16 dr_var 16
scoreboard players set #m36 dr_var 36
scoreboard players set #m100 dr_var 100
scoreboard players set #m2 dr_var 2
execute store result score #mround dr_var run data get storage derailed:mound cfg.round
execute store result score #msmin dr_var run data get storage derailed:mound cfg.smin
execute store result score #mmax dr_var run data get storage derailed:mound cfg.max
execute store result score #mpk dr_var run data get storage derailed:mound cfg.pk
execute store result score #mspk dr_var run data get storage derailed:mound cfg.spike
execute store result score #mspkpx dr_var run data get storage derailed:mound cfg.spikepx

# A marker on every tile of the map and of a ring one tile out round it, which
#  says whether the mound goes on past the map's edge, and on every corner
#  between the map's tiles, a layer above
scoreboard players set #mj dr_var -1
$execute positioned $(sx) $(sy) $(sz) positioned ~-1 ~ ~-1 run function derailed:dev/mound/_lay_row

# How far in from the edge of its region every tile of iron is, counting in only
#  from blocks that are neither iron nor air, since a mound goes on through air;
#  one no such block is anywhere near is as far in as a tile can be
scoreboard players set #mk dr_var 1
function derailed:dev/mound/_depth
scoreboard players set @e[type=marker,tag=dr_mt,scores={dr_md=-1},distance=0..] dr_md 32

# How high every corner stands, from how far in it is, then a few peaks
execute as @e[type=marker,tag=dr_mc,distance=0..] at @s run function derailed:dev/mound/_corner
function derailed:dev/mound/_peaks

# The tallest a column can come to is the highest corner nudged up as far as a
#  column can be, a spike on top where the kind has them, kept to the kind's
#  highest, and rounded up to whole blocks
scoreboard players set #mtop dr_var 0
execute as @e[type=marker,tag=dr_mc,distance=0..] run scoreboard players operation #mtop dr_var > @s dr_mh
execute store result score #mt dr_var run data get storage derailed:mound cfg.jit
scoreboard players operation #mtop dr_var += #mt dr_var
execute store result score #mt dr_var run data get storage derailed:mound cfg.tjit
scoreboard players operation #mtop dr_var += #mt dr_var
execute if score #mspk dr_var matches 1.. run scoreboard players operation #mtop dr_var += #mspkpx dr_var
execute if score #mtop dr_var > #mmax dr_var run scoreboard players operation #mtop dr_var = #mmax dr_var
scoreboard players add #mtop dr_var 15
scoreboard players operation #mtop dr_var /= #m16 dr_var
execute store result storage derailed:mound t.h int 1 run scoreboard players remove #mtop dr_var 1

execute as @e[type=marker,tag=dr_mt,tag=!dr_mring,scores={dr_mi=1},distance=0..] at @s run function derailed:dev/mound/_tile

execute store result score #mn dr_var if entity @e[type=marker,tag=dr_mt,tag=!dr_mring,scores={dr_mi=1},distance=0..]
scoreboard players set #mM dr_var 0
execute as @e[type=marker,tag=dr_mt,tag=!dr_mring,scores={dr_mi=1},distance=0..] run scoreboard players operation #mM dr_var > @s dr_md
tellraw @a [{text:"[mound] ",color:"gray"},{score:{name:"#mn",objective:"dr_var"}},{text:" tiles, deepest "},{score:{name:"#mM",objective:"dr_var"}},{text:" tiles in, "},{score:{name:"#mp",objective:"dr_var"}},{text:" peaks"}]

kill @e[type=marker,tag=dr_mt,distance=0..]
kill @e[type=marker,tag=dr_mc,distance=0..]
