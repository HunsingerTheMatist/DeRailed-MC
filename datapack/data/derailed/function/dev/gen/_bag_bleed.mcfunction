
# Charges the bag for what the seam carried in, kind by kind: the tiles a kind
#  bled into this section, over the tiles an average region has, is that many
#  regions of it drawn already, taken off the bag as a whole share each

execute if score #bleed_ground dr_var matches 1.. run scoreboard players set #gen_kind dr_var 0
execute if score #bleed_ground dr_var matches 1.. run scoreboard players operation #bag_take dr_var = #bleed_ground dr_var
execute if score #bleed_ground dr_var matches 1.. run function derailed:dev/gen/_bag_bleed_take

execute if score #bleed_wood dr_var matches 1.. run scoreboard players set #gen_kind dr_var 1
execute if score #bleed_wood dr_var matches 1.. run scoreboard players operation #bag_take dr_var = #bleed_wood dr_var
execute if score #bleed_wood dr_var matches 1.. run function derailed:dev/gen/_bag_bleed_take

execute if score #bleed_iron dr_var matches 1.. run scoreboard players set #gen_kind dr_var 2
execute if score #bleed_iron dr_var matches 1.. run scoreboard players operation #bag_take dr_var = #bleed_iron dr_var
execute if score #bleed_iron dr_var matches 1.. run function derailed:dev/gen/_bag_bleed_take

execute if score #bleed_water dr_var matches 1.. run scoreboard players set #gen_kind dr_var 3
execute if score #bleed_water dr_var matches 1.. run scoreboard players operation #bag_take dr_var = #bleed_water dr_var
execute if score #bleed_water dr_var matches 1.. run function derailed:dev/gen/_bag_bleed_take

execute if score #bleed_rock dr_var matches 1.. run scoreboard players set #gen_kind dr_var 4
execute if score #bleed_rock dr_var matches 1.. run scoreboard players operation #bag_take dr_var = #bleed_rock dr_var
execute if score #bleed_rock dr_var matches 1.. run function derailed:dev/gen/_bag_bleed_take
