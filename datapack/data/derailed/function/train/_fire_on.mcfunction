# Lays the fire over this burning piece of a train: a display of the piece's
#  '_burning' model riding it, drawn full bright, scaled and turned as the
#  piece's own model is, so its fire lies over the piece block for block, of
#  the piece's id and team
# Run as the piece's item display, at it

execute if entity @s[tag=dr_train_engine] run summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_fire","dr_fire_new"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:train_burning"}},brightness:{block:15,sky:15},interpolation_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2.5f,2.5f,2.5f]}}
execute if entity @s[tag=dr_train_water] run summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_fire","dr_fire_new"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:water_wagon_burning"}},brightness:{block:15,sky:15},interpolation_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
execute if entity @s[tag=dr_train_supply] run summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_fire","dr_fire_new"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:supply_wagon_burning"}},brightness:{block:15,sky:15},interpolation_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}
execute if entity @s[tag=dr_train_crafting] run summon item_display ~ ~ ~ {Tags:["dr_train_part","dr_fire","dr_fire_new"],item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:crafting_wagon_burning"}},brightness:{block:15,sky:15},interpolation_duration:1,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}

data modify entity @n[type=item_display,tag=dr_fire_new,distance=..0.1] transformation.left_rotation set from entity @s transformation.left_rotation
scoreboard players operation @e[type=item_display,tag=dr_fire_new,distance=..0.1] dr_tid = @s dr_tid
scoreboard players operation @e[type=item_display,tag=dr_fire_new,distance=..0.1] dr_team = @s dr_team
ride @n[type=item_display,tag=dr_fire_new,distance=..0.1] mount @s
tag @e[type=item_display,tag=dr_fire_new,distance=0..] remove dr_fire_new
