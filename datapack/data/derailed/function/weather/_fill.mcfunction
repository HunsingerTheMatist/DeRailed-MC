# Fills this empty bucket on the ground with rain, its display drawn full
# Run as the bucket's placement interaction, at it

scoreboard players operation @s dr_item = $BucketFull dr_const
execute positioned ~ ~0.5 ~ run item modify entity @n[type=item_display,distance=..0.1,tag=dr_placement] container.0 [{type:"set_components",components:{custom_model_data:{strings:["filled"]}}}]
