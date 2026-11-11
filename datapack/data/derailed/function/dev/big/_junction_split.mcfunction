
# Makes this river tile a split, fed the one way it is and leaving both its own
#  way and the other
# Run as the tile's marker

tag @s add dr_big_junction
data modify entity @s data.j set value {kind:"split"}
execute if entity @s[tag=dr_big_in_n] run data modify entity @s data.j.a set value "n"
execute if entity @s[tag=dr_big_in_e] run data modify entity @s data.j.a set value "e"
execute if entity @s[tag=dr_big_in_s] run data modify entity @s data.j.a set value "s"
execute if entity @s[tag=dr_big_in_w] run data modify entity @s data.j.a set value "w"
execute if entity @s[tag=dr_big_n,tag=dr_big_out_e] run data modify entity @s data.j.b set value "ne"
execute if entity @s[tag=dr_big_e,tag=dr_big_out_n] run data modify entity @s data.j.b set value "ne"
execute if entity @s[tag=dr_big_n,tag=dr_big_out_s] run data modify entity @s data.j.b set value "ns"
execute if entity @s[tag=dr_big_s,tag=dr_big_out_n] run data modify entity @s data.j.b set value "ns"
execute if entity @s[tag=dr_big_n,tag=dr_big_out_w] run data modify entity @s data.j.b set value "nw"
execute if entity @s[tag=dr_big_w,tag=dr_big_out_n] run data modify entity @s data.j.b set value "nw"
execute if entity @s[tag=dr_big_e,tag=dr_big_out_s] run data modify entity @s data.j.b set value "es"
execute if entity @s[tag=dr_big_s,tag=dr_big_out_e] run data modify entity @s data.j.b set value "es"
execute if entity @s[tag=dr_big_e,tag=dr_big_out_w] run data modify entity @s data.j.b set value "ew"
execute if entity @s[tag=dr_big_w,tag=dr_big_out_e] run data modify entity @s data.j.b set value "ew"
execute if entity @s[tag=dr_big_s,tag=dr_big_out_w] run data modify entity @s data.j.b set value "sw"
execute if entity @s[tag=dr_big_w,tag=dr_big_out_s] run data modify entity @s data.j.b set value "sw"
