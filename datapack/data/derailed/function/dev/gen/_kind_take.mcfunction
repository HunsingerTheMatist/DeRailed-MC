
# Gives this seed the kind chosen for it and pays it against the floor it counts
#  toward
# Run as the seed

scoreboard players operation @s dr_kind = #gen_kind dr_var
scoreboard players remove #kind_left dr_var 1

execute if score #gen_kind dr_var matches 1 if score #kind_owe_wood dr_var matches 1.. run scoreboard players remove #kind_owed dr_var 1
execute if score #gen_kind dr_var matches 1 if score #kind_owe_wood dr_var matches 1.. run scoreboard players remove #kind_owe_wood dr_var 1
execute if score #gen_kind dr_var matches 2 if score #kind_owe_iron dr_var matches 1.. run scoreboard players remove #kind_owed dr_var 1
execute if score #gen_kind dr_var matches 2 if score #kind_owe_iron dr_var matches 1.. run scoreboard players remove #kind_owe_iron dr_var 1
execute if score #gen_kind dr_var matches 3 if score #kind_owe_water dr_var matches 1.. run scoreboard players remove #kind_owed dr_var 1
execute if score #gen_kind dr_var matches 3 if score #kind_owe_water dr_var matches 1.. run scoreboard players remove #kind_owe_water dr_var 1
execute if score #gen_kind dr_var matches 4 if score #kind_owe_rock dr_var matches 1.. run scoreboard players remove #kind_owed dr_var 1
execute if score #gen_kind dr_var matches 4 if score #kind_owe_rock dr_var matches 1.. run scoreboard players remove #kind_owe_rock dr_var 1
