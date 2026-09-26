
# Counts the tile onto its region's seed, in column $(c) and in all, and where
#  the supply count cannot take the region, onto the tiles it cannot take of
#  the region's kind
# Run as the seed, positioned on the tile

$scoreboard players add @s dr_c$(c) 1
scoreboard players add @s dr_ctot 1
execute if entity @s[tag=dr_untake,scores={dr_kind=1}] if block ~ ~ ~ brown_concrete run scoreboard players add #rep_uw dr_var 1
execute if entity @s[tag=dr_untake,scores={dr_kind=2}] if block ~ ~ ~ light_gray_concrete run scoreboard players add #rep_ui dr_var 1
