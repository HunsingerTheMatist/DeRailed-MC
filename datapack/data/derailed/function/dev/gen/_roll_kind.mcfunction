
# Gives this seed its kind, which its whole region will be grown as

# A region the river ran out against is water whatever the roll would have been,
#  so a reroll cannot leave the river ending on dry ground
execute if entity @s[tag=dr_lake] run return run scoreboard players set @s dr_kind 3

execute if entity @s[tag=dr_chain] run function derailed:dev/gen/_pick_kind_chain
execute unless entity @s[tag=dr_chain] run function derailed:dev/gen/_pick_kind

scoreboard players operation @s dr_kind = #gen_kind dr_var
