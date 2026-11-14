
# Counts the changes for the sides to be $(n), $(e), $(s) and $(w), north to
#  west, "f" a full block, "s" a slab, "a" air, "o" a slab or air and "r" a slab
#  or a full block, and keeps them in '#ch_best' and 'chest.edit' where they
#  are fewer than the fewest yet

$scoreboard players operation #ch_c dr_temp = #ch_$(n)n dr_temp
$scoreboard players operation #ch_c dr_temp += #ch_$(e)e dr_temp
$scoreboard players operation #ch_c dr_temp += #ch_$(s)s dr_temp
$scoreboard players operation #ch_c dr_temp += #ch_$(w)w dr_temp
execute unless score #ch_c dr_temp < #ch_best dr_temp run return 0
scoreboard players operation #ch_best dr_temp = #ch_c dr_temp
$data modify storage derailed:big chest.edit set value {n:"$(n)",e:"$(e)",s:"$(s)",w:"$(w)"}
