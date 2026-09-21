
# Claims this seed's own tile as its region, ready for wave 0

scoreboard players operation #gen_id dr_var = @s dr_id

function derailed:dev/gen/_set_id
execute if block ~1 ~ ~ air summon marker run function derailed:dev/gen/_edge_mark
execute summon marker run function derailed:dev/gen/_born_0
scoreboard players add #gen_pending dr_var 1
