
# Works out this corner's depth, the least of the four tiles round it, and from
#  that how high it stands: a start taken at random, a share taken at random of
#  the rise for its depth, and a little either way for any corner inside a
#  region
# Run as the corner's marker, at it

scoreboard players set #mc dr_var 99
function derailed:dev/mound/_corner_nb {x:-1,z:-1}
function derailed:dev/mound/_corner_nb {x:0,z:-1}
function derailed:dev/mound/_corner_nb {x:-1,z:0}
function derailed:dev/mound/_corner_nb {x:0,z:0}
scoreboard players operation @s dr_md = #mc dr_var

execute if score #mc dr_var matches 6.. run scoreboard players set #mc dr_var 5
execute store result storage derailed:mound r.i int 1 run scoreboard players get #mc dr_var
function derailed:dev/mound/_rise with storage derailed:mound r
function derailed:dev/mound/_share with storage derailed:mound cfg
scoreboard players operation @s dr_mh *= #mj dr_var
scoreboard players operation @s dr_mh /= #m100 dr_var
function derailed:dev/mound/_start with storage derailed:mound cfg
scoreboard players operation @s dr_mh += #mj dr_var

data modify storage derailed:mound r.v set from storage derailed:mound cfg.noise
execute if score @s dr_md matches 1.. run function derailed:dev/mound/_nudge with storage derailed:mound r
execute if score @s dr_md matches 1.. run scoreboard players operation @s dr_mh += #mj dr_var
