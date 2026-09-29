
# Draws a kind for this seed from the bag, leaving it in '#gen_kind', then takes
#  a part of a seed's share off that kind and hands it out to the others, so
#  that a kind drawn often grows less likely, and for a while impossible, while
#  the rest catch up
# Only what the bag holds above nothing is rolled over, since a kind in debt is
#  sitting out

scoreboard players set #bag_pos dr_var 0
execute if score #bag_ground dr_var matches 1.. run scoreboard players operation #bag_pos dr_var += #bag_ground dr_var
execute if score #bag_wood dr_var matches 1.. run scoreboard players operation #bag_pos dr_var += #bag_wood dr_var
execute if score #bag_iron dr_var matches 1.. run scoreboard players operation #bag_pos dr_var += #bag_iron dr_var
execute if score #bag_water dr_var matches 1.. run scoreboard players operation #bag_pos dr_var += #bag_water dr_var
execute if score #bag_rock dr_var matches 1.. run scoreboard players operation #bag_pos dr_var += #bag_rock dr_var

# The range wanted changes with the bag, and a roll only takes a fixed one, so
#  the widest there is is rolled and folded down onto it
execute store result score #bag_roll dr_var run random value 0..2147483646 derailed:gen
scoreboard players operation #bag_roll dr_var %= #bag_pos dr_var
scoreboard players operation #bag_take dr_var = #bag_share dr_var

scoreboard players set #bag_acc dr_var 0
scoreboard players set #gen_kind dr_var 0
execute if score #bag_ground dr_var matches 1.. run scoreboard players operation #bag_acc dr_var += #bag_ground dr_var
execute if score #bag_roll dr_var < #bag_acc dr_var run return run function derailed:dev/gen/_bag_shift

scoreboard players set #gen_kind dr_var 1
execute if score #bag_wood dr_var matches 1.. run scoreboard players operation #bag_acc dr_var += #bag_wood dr_var
execute if score #bag_roll dr_var < #bag_acc dr_var run return run function derailed:dev/gen/_bag_shift

scoreboard players set #gen_kind dr_var 2
execute if score #bag_iron dr_var matches 1.. run scoreboard players operation #bag_acc dr_var += #bag_iron dr_var
execute if score #bag_roll dr_var < #bag_acc dr_var run return run function derailed:dev/gen/_bag_shift

scoreboard players set #gen_kind dr_var 3
execute if score #bag_water dr_var matches 1.. run scoreboard players operation #bag_acc dr_var += #bag_water dr_var
execute if score #bag_roll dr_var < #bag_acc dr_var run return run function derailed:dev/gen/_bag_shift

scoreboard players set #gen_kind dr_var 4
function derailed:dev/gen/_bag_shift
