
# Succeeds where a chest on this top block could be seen from the ground within
#  20 blocks of it across the ground, with the rock beside it changed as its
#  count found ('chest.edit'), which is put back as it was once it has been
#  looked at, from a copy at y2 under it: from a point 12/16 up the chest, two
#  pixels in from its side, rays go out each of sixteen ways a sixteenth of a
#  turn apart ('_chest_dir'), toward a player's eyes at every half block of the
#  ground from 1 block out to 20
# Run as the column's marker, at its top block

clone ~-1 ~ ~-1 ~1 ~ ~1 ~-1 2 ~-1 strict
function derailed:dev/big/_chest_edits
summon marker ~0.5 ~0.5 ~0.5 {Tags:["dr_chest_self"]}
summon marker ~0.5 16.62 ~0.5 {Tags:["dr_chest_walker"]}
scoreboard players set #ch_seen dr_temp 0
function derailed:dev/big/_chest_dir {yaw:0,px:0.5,pz:0.875,bx:0,bz:1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:22.5,px:0.3125,pz:0.875,bx:0,bz:1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:45,px:0.125,pz:0.875,bx:-1,bz:1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:67.5,px:0.125,pz:0.6875,bx:-1,bz:0}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:90,px:0.125,pz:0.5,bx:-1,bz:0}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:112.5,px:0.125,pz:0.3125,bx:-1,bz:0}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:135,px:0.125,pz:0.125,bx:-1,bz:-1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:157.5,px:0.3125,pz:0.125,bx:0,bz:-1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:180,px:0.5,pz:0.125,bx:0,bz:-1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:202.5,px:0.6875,pz:0.125,bx:0,bz:-1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:225,px:0.875,pz:0.125,bx:1,bz:-1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:247.5,px:0.875,pz:0.3125,bx:1,bz:0}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:270,px:0.875,pz:0.5,bx:1,bz:0}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:292.5,px:0.875,pz:0.6875,bx:1,bz:0}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:315,px:0.875,pz:0.875,bx:1,bz:1}
execute if score #ch_seen dr_temp matches 0 run function derailed:dev/big/_chest_dir {yaw:337.5,px:0.6875,pz:0.875,bx:0,bz:1}
kill @e[type=marker,tag=dr_chest_self,distance=..2]
kill @e[type=marker,tag=dr_chest_walker,distance=..64]
clone ~-1 2 ~-1 ~1 2 ~1 ~-1 ~ ~-1 strict
fill ~-1 2 ~-1 ~1 2 ~1 air strict
return run scoreboard players get #ch_seen dr_temp
