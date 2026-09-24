
# Works out what the section has to hold of each resource, from what the
#  dearer route needs, the bridges charged so far, and the margin on top

scoreboard players operation #need_wood dr_var = #need_wood_base dr_var
scoreboard players operation #need_iron dr_var = #need_iron_base dr_var
execute if score #gen_bridge dr_var matches 1 run scoreboard players operation #need_wood dr_var += #sup_bridges dr_var
execute if score #gen_bridge dr_var matches 2 run scoreboard players operation #need_iron dr_var += #sup_bridges dr_var

# The margin, rounded up
scoreboard players operation #need_wood dr_var *= #gen_supply_over dr_var
scoreboard players add #need_wood dr_var 99
scoreboard players operation #need_wood dr_var /= $Hundred dr_const
scoreboard players operation #need_iron dr_var *= #gen_supply_over dr_var
scoreboard players add #need_iron dr_var 99
scoreboard players operation #need_iron dr_var /= $Hundred dr_const
