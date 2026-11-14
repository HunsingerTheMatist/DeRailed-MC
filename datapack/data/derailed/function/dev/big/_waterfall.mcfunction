
# Hangs a waterfall, three blocks wide and twenty high, off each edge of this
#  water tile with nothing past it, a void tile or the map's edge: up from the
#  water's surface along its northern edge, as the water coming in, and down
#  from it along its southern, western and eastern edges, as the water going
#  out
# The one coming in reaches down through the water to its bed, a block below
#  this tile's marker in a lake and level with it in a river; those going out
#  start at the water's surface, 8/9 of a block up its block, as high as
#  vanilla draws still water and the fake water's flow model stands, 14 and
#  2/9 pixels, and the water's own sides are drawn as nothing
# Each is an item display of 'derailed:waterfall' a thousandth of a block out
#  past the edge, its sheet stood twenty high by its scale and turned a quarter
#  for the western and eastern edges, so it lies along them
# Run as the tile's marker, at it, two below the ground at its northwestern
#  block

execute if entity @s[tag=dr_big_river] positioned ~ ~ ~-3 unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] positioned ~ ~ ~3 run summon item_display ~1.5 ~ ~-0.001 {Tags:["dr_waterfall"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:waterfall"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,10f,0f],scale:[1f,6.666667f,1f]}}
execute if entity @s[tag=dr_big_lake] positioned ~ ~ ~-3 unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] positioned ~ ~ ~3 run summon item_display ~1.5 ~-1 ~-0.001 {Tags:["dr_waterfall"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:waterfall"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,10f,0f],scale:[1f,6.666667f,1f]}}
execute positioned ~ ~ ~3 unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] positioned ~ ~ ~-3 run summon item_display ~1.5 ~1.888889 ~3.001 {Tags:["dr_waterfall"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:waterfall"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-10f,0f],scale:[1f,6.666667f,1f]}}
execute positioned ~-3 ~ ~ unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] positioned ~3 ~ ~ run summon item_display ~-0.001 ~1.888889 ~1.5 {Tags:["dr_waterfall"],Rotation:[90f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:waterfall"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-10f,0f],scale:[1f,6.666667f,1f]}}
execute positioned ~3 ~ ~ unless entity @e[type=marker,tag=dr_big,tag=!dr_big_void,distance=..0.5] positioned ~-3 ~ ~ run summon item_display ~3.001 ~1.888889 ~1.5 {Tags:["dr_waterfall"],Rotation:[90f,0f],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:waterfall"}},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,-10f,0f],scale:[1f,6.666667f,1f]}}
