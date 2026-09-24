
# Counts the wood and iron seeds within reach of a route in the window that
#  starts at column $(x) and runs $(dx) columns past it, on the rows from
#  $(z) down, whichever section they belong to, and marks this section's
#  seeds that lie in it

$execute store result score #sp_wood dr_var if entity @e[type=marker,tag=dr_supply,scores={dr_kind=1},x=$(x),dx=$(dx),y=-64,dy=384,z=$(z),dz=15]
$execute store result score #sp_iron dr_var if entity @e[type=marker,tag=dr_supply,scores={dr_kind=2},x=$(x),dx=$(dx),y=-64,dy=384,z=$(z),dz=15]

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_win
$tag @e[type=marker,tag=dr_seed,x=$(x),dx=$(dx),y=-64,dy=384,z=$(z),dz=15] add dr_win
