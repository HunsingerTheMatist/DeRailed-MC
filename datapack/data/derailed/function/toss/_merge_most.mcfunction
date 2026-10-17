# Merges this thrown pile into the touching pile, tagged 'dr_toss_touch',
#  holding the most, the nearest of those holding as many, then goes on to the
#  next while any of its items are left
# Run as the thrown display, at it

execute if score @s dr_count matches ..0 run return 0
execute unless entity @e[type=interaction,tag=dr_toss_touch,distance=..4] run return 0

scoreboard players set #toss_most dr_temp -1
execute as @e[type=interaction,tag=dr_toss_touch,distance=..4] run scoreboard players operation #toss_most dr_temp > @s dr_count
execute as @e[type=interaction,tag=dr_toss_touch,distance=..4] if score @s dr_count = #toss_most dr_temp run tag @s add dr_toss_most
tag @n[type=interaction,tag=dr_toss_most,distance=..4] add dr_toss_chosen
tag @e[type=interaction,tag=dr_toss_most,distance=..4] remove dr_toss_most

execute at @n[type=interaction,tag=dr_toss_chosen,distance=..4] run function derailed:toss/_merge_into
tag @n[type=interaction,tag=dr_toss_chosen,distance=..4] remove dr_toss_touch
tag @n[type=interaction,tag=dr_toss_chosen,distance=..4] remove dr_toss_chosen
function derailed:toss/_merge_most
