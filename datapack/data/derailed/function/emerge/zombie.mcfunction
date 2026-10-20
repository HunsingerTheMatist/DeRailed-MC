# Starts a zombie climbing out of the ground here the way a warden emerges: a
#  display of it stepping through the 'zombie_emerge' frames, one a tick, and a
#  zombie in its place once it is out
# The display shows the frames at twice their size, and lit as the open sky
#  lights it, so it is not drawn dark while it is still underground
# Run where the zombie is to stand, facing the way it is to face

summon item_display ~ ~ ~ {Tags:["dr_emerge","dr_emerge_new"],brightness:{sky:15,block:0},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]},item:{id:"minecraft:stick",count:1,components:{"minecraft:item_model":"derailed:zombie_emerge","minecraft:custom_model_data":{floats:[0f]}}}}
execute as @n[type=item_display,tag=dr_emerge_new,distance=..0.1] run tp @s ~ ~ ~ ~ 0
scoreboard players set @n[type=item_display,tag=dr_emerge_new,distance=..0.1] dr_emerge 0
tag @n[type=item_display,tag=dr_emerge_new,distance=..0.1] remove dr_emerge_new
