
# Makes this river tile a merge, fed the two ways it is and leaving its own way
# Run as the tile's marker

tag @s add dr_big_junction
data modify entity @s data.j set value {kind:"merge"}
execute if entity @s[tag=dr_big_in_n,tag=dr_big_in_e] run data modify entity @s data.j.a set value "ne"
execute if entity @s[tag=dr_big_in_n,tag=dr_big_in_s] run data modify entity @s data.j.a set value "ns"
execute if entity @s[tag=dr_big_in_n,tag=dr_big_in_w] run data modify entity @s data.j.a set value "nw"
execute if entity @s[tag=dr_big_in_e,tag=dr_big_in_s] run data modify entity @s data.j.a set value "es"
execute if entity @s[tag=dr_big_in_e,tag=dr_big_in_w] run data modify entity @s data.j.a set value "ew"
execute if entity @s[tag=dr_big_in_s,tag=dr_big_in_w] run data modify entity @s data.j.a set value "sw"
execute if entity @s[tag=dr_big_n] run data modify entity @s data.j.b set value "n"
execute if entity @s[tag=dr_big_e] run data modify entity @s data.j.b set value "e"
execute if entity @s[tag=dr_big_s] run data modify entity @s data.j.b set value "s"
execute if entity @s[tag=dr_big_w] run data modify entity @s data.j.b set value "w"
