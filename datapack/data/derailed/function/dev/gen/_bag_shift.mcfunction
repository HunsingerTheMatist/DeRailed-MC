
# Takes '#bag_take' off the kind in '#gen_kind', letting it fall below nothing,
#  and hands the same amount out to the other kinds in the tier's own ratios
# A kind below nothing is left out of the roll until picks of the others have
#  paid it back, each giving it its part of what they took, so a kind drawn too
#  often has to sit out until the bag has drawn a good deal of everything else
# What the rounding loses is a few units a pick, and it is let go: the roll
#  runs over what the bag holds rather than over a fixed total

# What the others are owed between them, by the intended weights
scoreboard players operation #bag_rest dr_var = #base_ground dr_var
scoreboard players operation #bag_rest dr_var += #base_wood dr_var
scoreboard players operation #bag_rest dr_var += #base_iron dr_var
scoreboard players operation #bag_rest dr_var += #base_water dr_var
scoreboard players operation #bag_rest dr_var += #base_rock dr_var
execute if score #gen_kind dr_var matches 0 run scoreboard players operation #bag_rest dr_var -= #base_ground dr_var
execute if score #gen_kind dr_var matches 1 run scoreboard players operation #bag_rest dr_var -= #base_wood dr_var
execute if score #gen_kind dr_var matches 2 run scoreboard players operation #bag_rest dr_var -= #base_iron dr_var
execute if score #gen_kind dr_var matches 3 run scoreboard players operation #bag_rest dr_var -= #base_water dr_var
execute if score #gen_kind dr_var matches 4 run scoreboard players operation #bag_rest dr_var -= #base_rock dr_var
execute if score #bag_rest dr_var matches ..0 run return 0

execute if score #gen_kind dr_var matches 0 run scoreboard players operation #bag_ground dr_var -= #bag_take dr_var
execute if score #gen_kind dr_var matches 1 run scoreboard players operation #bag_wood dr_var -= #bag_take dr_var
execute if score #gen_kind dr_var matches 2 run scoreboard players operation #bag_iron dr_var -= #bag_take dr_var
execute if score #gen_kind dr_var matches 3 run scoreboard players operation #bag_water dr_var -= #bag_take dr_var
execute if score #gen_kind dr_var matches 4 run scoreboard players operation #bag_rock dr_var -= #bag_take dr_var

scoreboard players operation #bag_add dr_var = #base_ground dr_var
scoreboard players operation #bag_add dr_var *= #bag_take dr_var
scoreboard players operation #bag_add dr_var /= #bag_rest dr_var
execute unless score #gen_kind dr_var matches 0 run scoreboard players operation #bag_ground dr_var += #bag_add dr_var
scoreboard players operation #bag_add dr_var = #base_wood dr_var
scoreboard players operation #bag_add dr_var *= #bag_take dr_var
scoreboard players operation #bag_add dr_var /= #bag_rest dr_var
execute unless score #gen_kind dr_var matches 1 run scoreboard players operation #bag_wood dr_var += #bag_add dr_var
scoreboard players operation #bag_add dr_var = #base_iron dr_var
scoreboard players operation #bag_add dr_var *= #bag_take dr_var
scoreboard players operation #bag_add dr_var /= #bag_rest dr_var
execute unless score #gen_kind dr_var matches 2 run scoreboard players operation #bag_iron dr_var += #bag_add dr_var
scoreboard players operation #bag_add dr_var = #base_water dr_var
scoreboard players operation #bag_add dr_var *= #bag_take dr_var
scoreboard players operation #bag_add dr_var /= #bag_rest dr_var
execute unless score #gen_kind dr_var matches 3 run scoreboard players operation #bag_water dr_var += #bag_add dr_var
scoreboard players operation #bag_add dr_var = #base_rock dr_var
scoreboard players operation #bag_add dr_var *= #bag_take dr_var
scoreboard players operation #bag_add dr_var /= #bag_rest dr_var
execute unless score #gen_kind dr_var matches 4 run scoreboard players operation #bag_rock dr_var += #bag_add dr_var
