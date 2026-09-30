
# Makes one region the players reach before their wood ran out wood, and returns
#  1 where it made one, for the supply and the order to be checked again
# The region is ground, iron or water, never rock, a wall or a lake, and only
#  iron where the first route runs through it, which the route pays the same
#  for; of those, one reached at the lowest level, taken at random, ground
#  before iron before water. Ground is repainted outright; iron and water swap
#  kinds with a wood region the players do not reach in time, which keeps every
#  kind at its count, and are repainted outright only where no such region
#  exists and their kind holds more regions than its floor
# Positioned at the section's corner, on the visible layer, with the routes
#  drawn two above

scoreboard players remove #ofix_left dr_var 1

function derailed:dev/gen/_order_cands
execute unless entity @e[type=marker,tag=dr_ocand,distance=0..] run return 0

scoreboard players set #olow dr_var 999
execute as @e[type=marker,tag=dr_ocand,distance=0..] run scoreboard players operation #olow dr_var < @s dr_olev
execute as @e[type=marker,tag=dr_ocand,distance=0..] unless score @s dr_olev = #olow dr_var run tag @s remove dr_ocand
tag @e[type=marker,tag=dr_ocand,distance=0..] add dr_pickc
function derailed:dev/gen/_pick
tag @e[type=marker,tag=dr_picked,distance=0..] add dr_oa
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ocand
execute as @n[type=marker,tag=dr_oa,distance=0..] run scoreboard players operation #okind dr_var = @s dr_kind

# The wood region to swap with, for iron or water
execute unless score #okind dr_var matches 0 as @e[type=marker,tag=dr_seed,tag=!dr_wall,tag=!dr_lake,scores={dr_kind=1},distance=0..] if score @s dr_olev > #oL dr_var run tag @s add dr_ocand
execute if score #okind dr_var matches 3 run tag @e[type=marker,tag=dr_ocand,tag=dr_ofirst,distance=0..] remove dr_ocand
tag @e[type=marker,tag=dr_ocand,distance=0..] add dr_pickc
function derailed:dev/gen/_pick
tag @e[type=marker,tag=dr_picked,distance=0..] add dr_ob
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ocand

# Iron or water with nothing to swap with is repainted outright only above its
#  floor
scoreboard players set #ogo dr_var 1
execute store result score #cnt_iron dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]
execute store result score #cnt_water dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=3},distance=0..]
execute if score #okind dr_var matches 2 unless entity @e[type=marker,tag=dr_ob,distance=0..] if score #cnt_iron dr_var <= #gen_min_iron dr_var run scoreboard players set #ogo dr_var 0
execute if score #okind dr_var matches 3 unless entity @e[type=marker,tag=dr_ob,distance=0..] if score #cnt_water dr_var <= #gen_min_water dr_var run scoreboard players set #ogo dr_var 0

execute if score #ogo dr_var matches 1 run scoreboard players set #sup_want dr_var 1
execute if score #ogo dr_var matches 1 as @n[type=marker,tag=dr_oa,distance=0..] run function derailed:dev/gen/_supply_repaint
execute if score #ogo dr_var matches 1 run scoreboard players operation #sup_want dr_var = #okind dr_var
execute if score #ogo dr_var matches 1 as @n[type=marker,tag=dr_ob,distance=0..] run function derailed:dev/gen/_supply_repaint

# The wood made here is kept out of the supply's repair from now on, so that it
#  cannot trade it back away
execute if score #ogo dr_var matches 1 run tag @n[type=marker,tag=dr_oa,distance=0..] add dr_ofixed
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_oa
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_ob
execute if score #ogo dr_var matches 0 run return 0
scoreboard players add #ofixed dr_var 1
return 1
