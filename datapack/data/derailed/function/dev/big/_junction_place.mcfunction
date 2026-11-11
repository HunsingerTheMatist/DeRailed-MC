
# Lays this junction's surface over its river, piece $(kind)_$(a)_$(b), and the
#  part of it on each side it is fed from or leaves by where the tile on that
#  side is a straight river flowing into it or out of it, the way the piece
#  expects; a bend or another junction there is left as it is
# Run as the junction's marker, at it

$place template derailed:river/$(kind)_$(a)_$(b) ~-1 ~1 ~-1 none none 1 0 strict

$execute if entity @s[tag=dr_big_in_s] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/$(kind)_$(a)_$(b)_n ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_in_w] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/$(kind)_$(a)_$(b)_e ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_in_n] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/$(kind)_$(a)_$(b)_s ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_in_e] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/$(kind)_$(a)_$(b)_w ~-1 ~1 ~-1 none none 1 0 strict

$execute if entity @s[tag=dr_big_n] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/$(kind)_$(a)_$(b)_n ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_out_n] positioned ~ ~ ~-3 if entity @e[type=marker,tag=dr_big_n,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~ ~ ~3 run place template derailed:river/$(kind)_$(a)_$(b)_n ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_e] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/$(kind)_$(a)_$(b)_e ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_out_e] positioned ~3 ~ ~ if entity @e[type=marker,tag=dr_big_e,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~-3 ~ ~ run place template derailed:river/$(kind)_$(a)_$(b)_e ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_s] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/$(kind)_$(a)_$(b)_s ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_out_s] positioned ~ ~ ~3 if entity @e[type=marker,tag=dr_big_s,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~ ~ ~-3 run place template derailed:river/$(kind)_$(a)_$(b)_s ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_w] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/$(kind)_$(a)_$(b)_w ~-1 ~1 ~-1 none none 1 0 strict
$execute if entity @s[tag=dr_big_out_w] positioned ~-3 ~ ~ if entity @e[type=marker,tag=dr_big_w,tag=!dr_big_bend,tag=!dr_big_junction,distance=..0.5] positioned ~3 ~ ~ run place template derailed:river/$(kind)_$(a)_$(b)_w ~-1 ~1 ~-1 none none 1 0 strict
