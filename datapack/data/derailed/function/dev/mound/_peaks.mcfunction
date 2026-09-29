
# Raises one to as many corners as the kind's 'peaks' at random two or more
#  tiles in, where at least three are, by twice '#mpk' pixels, and every corner
#  of a region beside one by '#mpk', so that a big mound has humps rather than
#  one summit

scoreboard players set #mp dr_var 0
execute store result score #mq dr_var if entity @e[type=marker,tag=dr_mc,scores={dr_md=2..},distance=0..]
execute if score #mq dr_var matches ..2 run return 0

function derailed:dev/mound/_peak_count with storage derailed:mound cfg
execute if score #mp dr_var matches 1.. run tag @e[type=marker,tag=dr_mc,tag=!dr_mpeak,scores={dr_md=2..},distance=0..,sort=random,limit=1] add dr_mpeak
execute if score #mp dr_var matches 2.. run tag @e[type=marker,tag=dr_mc,tag=!dr_mpeak,scores={dr_md=2..},distance=0..,sort=random,limit=1] add dr_mpeak
execute if score #mp dr_var matches 3.. run tag @e[type=marker,tag=dr_mc,tag=!dr_mpeak,scores={dr_md=2..},distance=0..,sort=random,limit=1] add dr_mpeak
execute if score #mp dr_var matches 4.. run tag @e[type=marker,tag=dr_mc,tag=!dr_mpeak,scores={dr_md=2..},distance=0..,sort=random,limit=1] add dr_mpeak
execute if score #mp dr_var matches 5.. run tag @e[type=marker,tag=dr_mc,tag=!dr_mpeak,scores={dr_md=2..},distance=0..,sort=random,limit=1] add dr_mpeak

execute as @e[type=marker,tag=dr_mc,scores={dr_md=1..},distance=0..] at @s if entity @e[type=marker,tag=dr_mpeak,distance=..1.5] run scoreboard players operation @s dr_mh += #mpk dr_var
execute as @e[type=marker,tag=dr_mpeak,distance=0..] run scoreboard players operation @s dr_mh += #mpk dr_var
tag @e[type=marker,tag=dr_mpeak,distance=0..] remove dr_mpeak
