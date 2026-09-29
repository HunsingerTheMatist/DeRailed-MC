
# Gives '#pl_kind' to a seed still to be placed whose seed lies between column
#  $(x) and $(dx) columns past it, on the rows from $(z) down, taken at random,
#  or with none there to the one nearest the band's middle, column $(mx), row
#  $(mz)

scoreboard players set #pl_done dr_var 0
$tag @e[type=marker,tag=dr_place,x=$(x),dx=$(dx),y=-64,dy=384,z=$(z),dz=15] add dr_pickc
function derailed:dev/gen/_pick
execute as @e[type=marker,tag=dr_picked,distance=0..] run function derailed:dev/gen/_kind_give
$execute if score #pl_done dr_var matches 0 positioned $(mx) ~ $(mz) as @n[type=marker,tag=dr_place,distance=0..] run function derailed:dev/gen/_kind_give
