# Throws #curr_item_count of #curr_item from here the way it faces, as
#  'toss/throw' does but taking nothing off anyone
# Run facing the throw

execute summon marker run function derailed:toss/_aim
summon item_display ~ ~ ~ {Tags:["dr_toss","dr_toss_new"],teleport_duration:1,Passengers:[{id:"minecraft:interaction",Tags:["dr_toss_box"],width:0.885f,height:0f}]}
execute as @n[type=item_display,tag=dr_toss_new,distance=..0.1] run function derailed:toss/_launch
