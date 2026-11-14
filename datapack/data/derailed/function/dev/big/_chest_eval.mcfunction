
# Works out the fewest changes to the rock beside this top block that give a
#  chest here the sides its difficulty asks for, into '#ch_best', 99 where none
#  will, and what each side is to be in 'chest.edit' of storage 'derailed:big',
#  "f" a full block, "s" a slab, "a" air, "o" a slab or air and "r" a slab or a
#  full block:
#    hard     a full block on all four sides
#    medium   a slab on two of the sides, a full block on one and a slab or a
#             full block on the last
#    easy     air on one side, a slab on one, a slab or air on one and a full
#             block on the last
# Each way of sharing those out among the sides is tried, the first of the
#  cheapest kept
# Positioned at the column's top block

scoreboard players set #ch_best dr_temp 99
function derailed:dev/big/_chest_cost {x:0,z:-1,s:"n"}
function derailed:dev/big/_chest_cost {x:1,z:0,s:"e"}
function derailed:dev/big/_chest_cost {x:0,z:1,s:"s"}
function derailed:dev/big/_chest_cost {x:-1,z:0,s:"w"}

execute if score $Difficulty dr_config matches 2.. run function derailed:dev/big/_chest_try {n:"f",e:"f",s:"f",w:"f"}

execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"s",e:"s",s:"f",w:"r"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"s",e:"s",s:"r",w:"f"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"s",e:"f",s:"s",w:"r"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"s",e:"f",s:"r",w:"s"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"s",e:"r",s:"s",w:"f"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"s",e:"r",s:"f",w:"s"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"f",e:"s",s:"s",w:"r"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"f",e:"s",s:"r",w:"s"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"f",e:"r",s:"s",w:"s"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"r",e:"s",s:"s",w:"f"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"r",e:"s",s:"f",w:"s"}
execute if score $Difficulty dr_config matches 1 run function derailed:dev/big/_chest_try {n:"r",e:"f",s:"s",w:"s"}

execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"a",e:"s",s:"o",w:"f"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"a",e:"s",s:"f",w:"o"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"a",e:"o",s:"s",w:"f"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"a",e:"o",s:"f",w:"s"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"a",e:"f",s:"s",w:"o"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"a",e:"f",s:"o",w:"s"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"s",e:"a",s:"o",w:"f"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"s",e:"a",s:"f",w:"o"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"s",e:"o",s:"a",w:"f"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"s",e:"o",s:"f",w:"a"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"s",e:"f",s:"a",w:"o"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"s",e:"f",s:"o",w:"a"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"o",e:"a",s:"s",w:"f"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"o",e:"a",s:"f",w:"s"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"o",e:"s",s:"a",w:"f"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"o",e:"s",s:"f",w:"a"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"o",e:"f",s:"a",w:"s"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"o",e:"f",s:"s",w:"a"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"f",e:"a",s:"s",w:"o"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"f",e:"a",s:"o",w:"s"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"f",e:"s",s:"a",w:"o"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"f",e:"s",s:"o",w:"a"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"f",e:"o",s:"a",w:"s"}
execute if score $Difficulty dr_config matches ..0 run function derailed:dev/big/_chest_try {n:"f",e:"o",s:"s",w:"a"}
