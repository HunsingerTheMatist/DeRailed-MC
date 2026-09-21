
# Prints one row of the seam and moves to the next

scoreboard players set #gen_kind dr_var -1
execute positioned ~-2 ~ ~ run function derailed:dev/gen/_read_kind
scoreboard players operation #d0 dr_var = #gen_kind dr_var

scoreboard players set #gen_kind dr_var -1
execute positioned ~-1 ~ ~ run function derailed:dev/gen/_read_kind
scoreboard players operation #d1 dr_var = #gen_kind dr_var

scoreboard players set #gen_kind dr_var -1
function derailed:dev/gen/_read_kind
scoreboard players operation #d2 dr_var = #gen_kind dr_var

scoreboard players set #gen_kind dr_var -1
execute positioned ~1 ~ ~ run function derailed:dev/gen/_read_kind
scoreboard players operation #d3 dr_var = #gen_kind dr_var

scoreboard players set #gen_kind dr_var -1
execute positioned ~2 ~ ~ run function derailed:dev/gen/_read_kind
scoreboard players operation #d4 dr_var = #gen_kind dr_var

scoreboard players set #gen_kind dr_var -1
execute positioned ~3 ~ ~ run function derailed:dev/gen/_read_kind
scoreboard players operation #d5 dr_var = #gen_kind dr_var

tellraw @a [{text:"[dump] row ",color:"gray"},{score:{name:"#gen_row",objective:"dr_var"}},{text:": "},{score:{name:"#d0",objective:"dr_var"}},{text:" "},{score:{name:"#d1",objective:"dr_var"}},{text:" | "},{score:{name:"#d2",objective:"dr_var"}},{text:" "},{score:{name:"#d3",objective:"dr_var"}},{text:" "},{score:{name:"#d4",objective:"dr_var"}},{text:" "},{score:{name:"#d5",objective:"dr_var"}}]

scoreboard players add #gen_row dr_var 1
execute if score #gen_row dr_var matches ..15 positioned ~ ~ ~1 run function derailed:dev/gen/_dump_row
