
# Puts a chest on this column and on the one tagged 'dr_big_second'
# Run as the first chest's column, at its top block

function derailed:dev/big/_chest_place
execute as @e[type=marker,tag=dr_big_second,distance=0..] at @s run function derailed:dev/big/_chest_place
return 1
