
# The model dispatches on stack count, so setting the count picks the model
scoreboard players operation #display_count dr_temp = #items_to_place dr_arg
execute store result entity @n[type=item_display,distance=..0.1,tag=dr_placement] item.count int 1 run scoreboard players operation #display_count dr_temp < $BatchHeight dr_const

execute unless score @s dr_count matches 1 positioned ~ ~-0.25 ~ unless entity @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] \
    run summon item_display ~ ~ ~ {Passengers:[{id:shulker,Invulnerable:true,NoAI:true,Health:1,attributes:[{id:scale,base:0.625}],active_effects:[{id:invisibility,duration:-1,show_particles:false}]}],Tags:[dr_placement_shulker]}

tellraw @a [{text:"Display count: "}, {score:{name:"#display_count",objective:dr_temp}}]
execute if score #display_count dr_temp matches 1 positioned ~ ~-0.25 ~ run return run tp @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] ~ ~-0.5 ~
execute if score #display_count dr_temp matches 2 positioned ~ ~-0.25 ~ run return run tp @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] ~ ~-0.125 ~
execute if score #display_count dr_temp matches 3 positioned ~ ~-0.25 ~ run return run tp @n[type=item_display,distance=..0.57,tag=dr_placement_shulker] ~ ~0.25 ~
