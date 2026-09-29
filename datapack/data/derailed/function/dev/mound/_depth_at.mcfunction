
# Gives this tile '#mk' as its depth where any of the four beside it is '#mprev'
#  deep, or any of the four at its corners while '#mdiag' is set
# Run as the tile's marker, at it

scoreboard players set #mf dr_var 0
function derailed:dev/mound/_depth_nb {x:1,z:0}
function derailed:dev/mound/_depth_nb {x:-1,z:0}
function derailed:dev/mound/_depth_nb {x:0,z:1}
function derailed:dev/mound/_depth_nb {x:0,z:-1}
execute if score #mdiag dr_var matches 1 run function derailed:dev/mound/_depth_nb {x:1,z:1}
execute if score #mdiag dr_var matches 1 run function derailed:dev/mound/_depth_nb {x:1,z:-1}
execute if score #mdiag dr_var matches 1 run function derailed:dev/mound/_depth_nb {x:-1,z:1}
execute if score #mdiag dr_var matches 1 run function derailed:dev/mound/_depth_nb {x:-1,z:-1}
execute if score #mf dr_var matches 1 run scoreboard players operation @s dr_md = #mk dr_var
