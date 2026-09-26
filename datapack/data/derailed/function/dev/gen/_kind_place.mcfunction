
# Sees that each half of the section holds some wood and some iron: the kinds
#  the draw gave the seeds off the wall and the lakes are kept, but handed out
#  again, one seed of wood in each half of the columns, then one of iron, and
#  every other seed of either, and the other kinds, going to the seeds left at
#  random, so that the rest may bunch or leave a stretch without
# Positioned at the section's corner

execute summon marker run function derailed:dev/gen/_read_corner
tag @e[type=marker,tag=dr_seed,tag=!dr_wall,tag=!dr_lake,distance=0..] add dr_place

execute store result score #pl_n0 dr_var if entity @e[type=marker,tag=dr_place,scores={dr_kind=0},distance=0..]
execute store result score #pl_n1 dr_var if entity @e[type=marker,tag=dr_place,scores={dr_kind=1},distance=0..]
execute store result score #pl_n2 dr_var if entity @e[type=marker,tag=dr_place,scores={dr_kind=2},distance=0..]
execute store result score #pl_n3 dr_var if entity @e[type=marker,tag=dr_place,scores={dr_kind=3},distance=0..]
execute store result score #pl_n4 dr_var if entity @e[type=marker,tag=dr_place,scores={dr_kind=4},distance=0..]

execute store result storage derailed:gen p.z int 1 run scoreboard players get #gen_cz dr_var
scoreboard players operation #pl_mz dr_var = #gen_cz dr_var
scoreboard players add #pl_mz dr_var 8
execute store result storage derailed:gen p.mz int 1 run scoreboard players get #pl_mz dr_var

# One of each in each half, where the draw gave that many
scoreboard players set #pl_kind dr_var 1
scoreboard players set #pl_bands dr_var 2
scoreboard players operation #pl_bands dr_var < #pl_n1 dr_var
scoreboard players operation #pl_n1 dr_var -= #pl_bands dr_var
scoreboard players set #pl_k dr_var 0
function derailed:dev/gen/_kind_band

scoreboard players set #pl_kind dr_var 2
scoreboard players set #pl_bands dr_var 2
scoreboard players operation #pl_bands dr_var < #pl_n2 dr_var
scoreboard players operation #pl_n2 dr_var -= #pl_bands dr_var
scoreboard players set #pl_k dr_var 0
function derailed:dev/gen/_kind_band

# Then everything else anywhere
scoreboard players set #pl_kind dr_var 1
scoreboard players operation #pl_left dr_var = #pl_n1 dr_var
function derailed:dev/gen/_kind_rest
scoreboard players set #pl_kind dr_var 2
scoreboard players operation #pl_left dr_var = #pl_n2 dr_var
function derailed:dev/gen/_kind_rest
scoreboard players set #pl_kind dr_var 0
scoreboard players operation #pl_left dr_var = #pl_n0 dr_var
function derailed:dev/gen/_kind_rest
scoreboard players set #pl_kind dr_var 3
scoreboard players operation #pl_left dr_var = #pl_n3 dr_var
function derailed:dev/gen/_kind_rest
scoreboard players set #pl_kind dr_var 4
scoreboard players operation #pl_left dr_var = #pl_n4 dr_var
function derailed:dev/gen/_kind_rest

tag @e[type=marker,tag=dr_place,distance=0..] remove dr_place
