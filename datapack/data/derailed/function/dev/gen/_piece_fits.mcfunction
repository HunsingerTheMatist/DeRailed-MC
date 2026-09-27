
# Succeeds where no tile the piece would cover is already a prefab's, the piece
#  covering columns $(x) and $(x1) from row $(z), '#pc_h' rows down
# Takes $(x), $(x1), $(z), $(z1) and $(z2), the rows below $(z)
# Positioned at the section's corner

$execute if block ~$(x) ~ ~$(z) #derailed:prefab run return fail
$execute if block ~$(x1) ~ ~$(z) #derailed:prefab run return fail
$execute if score #pc_h dr_var matches 2.. if block ~$(x) ~ ~$(z1) #derailed:prefab run return fail
$execute if score #pc_h dr_var matches 2.. if block ~$(x1) ~ ~$(z1) #derailed:prefab run return fail
$execute if score #pc_h dr_var matches 3.. if block ~$(x) ~ ~$(z2) #derailed:prefab run return fail
$execute if score #pc_h dr_var matches 3.. if block ~$(x1) ~ ~$(z2) #derailed:prefab run return fail
return 1
