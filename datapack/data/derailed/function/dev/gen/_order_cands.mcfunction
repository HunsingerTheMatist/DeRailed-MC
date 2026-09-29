
# Tags 'dr_ocand' the seeds of the regions '_order_fix' may make wood: those
#  the players reach by level '#oL', never a wall or a lake, ground before iron
#  before water, and ground or water only off the first route

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ocand
execute as @e[type=marker,tag=dr_seed,tag=!dr_wall,tag=!dr_lake,tag=!dr_ofirst,scores={dr_kind=0},distance=0..] if score @s dr_olev <= #oL dr_var run tag @s add dr_ocand
execute unless entity @e[type=marker,tag=dr_ocand,distance=0..] as @e[type=marker,tag=dr_seed,tag=!dr_wall,tag=!dr_lake,scores={dr_kind=2},distance=0..] if score @s dr_olev <= #oL dr_var run tag @s add dr_ocand
execute unless entity @e[type=marker,tag=dr_ocand,distance=0..] as @e[type=marker,tag=dr_seed,tag=!dr_wall,tag=!dr_lake,tag=!dr_ofirst,scores={dr_kind=3},distance=0..] if score @s dr_olev <= #oL dr_var run tag @s add dr_ocand
