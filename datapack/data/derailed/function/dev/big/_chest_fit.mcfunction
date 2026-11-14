
# Succeeds where a chest can go on this column with two changes or fewer to the
#  rock beside its top block ('_chest_eval') and, on easy, where it can be seen
#  from the ground ('_chest_seen'), and keeps the answer on the column,
#  'dr_big_fit' or 'dr_big_unfit', for the next time it is asked
# Run as the column's marker, at its top block

execute if entity @s[tag=dr_big_fit] run return 1
execute if entity @s[tag=dr_big_unfit] run return 0
function derailed:dev/big/_chest_eval
execute if score #ch_best dr_temp matches 3.. run tag @s add dr_big_unfit
execute if score $Difficulty dr_config matches ..0 unless entity @s[tag=dr_big_unfit] unless function derailed:dev/big/_chest_seen run tag @s add dr_big_unfit
execute if entity @s[tag=dr_big_unfit] run return 0
tag @s add dr_big_fit
return 1
