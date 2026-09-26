
# Counts this tile into zone $(z): as rock, river or out of the flood's reach,
#  and otherwise as its terrain by whose region it is, 'f' one of this
#  section's the first route runs through, 'o' another of this section's and
#  'x' none of this section's, with 'g', 'w', 'i' and 'a' for ground, wood,
#  iron and water, and anything else as 'etc'
# Positioned on the tile, with the flood's marks two above

$execute if block ~ ~ ~ gray_concrete run return run scoreboard players add #$(z)_rock dr_rim 1
$execute if block ~ ~ ~ light_blue_concrete run return run scoreboard players add #$(z)_river dr_rim 1
$execute unless block ~ ~2 ~ #derailed:flood_visited run return run scoreboard players add #$(z)_far dr_rim 1

function derailed:dev/gen/_read_owner
scoreboard players set #rim_own dr_var 0
execute as @e[type=marker,tag=dr_seed,distance=0..] if score @s dr_id = #gen_id dr_var run scoreboard players set #rim_own dr_var 1
execute as @e[type=marker,tag=dr_seed,tag=dr_on_first,distance=0..] if score @s dr_id = #gen_id dr_var run scoreboard players set #rim_own dr_var 2

$execute if score #rim_own dr_var matches 2 if block ~ ~ ~ lime_concrete run return run scoreboard players add #$(z)_fg dr_rim 1
$execute if score #rim_own dr_var matches 2 if block ~ ~ ~ brown_concrete run return run scoreboard players add #$(z)_fw dr_rim 1
$execute if score #rim_own dr_var matches 2 if block ~ ~ ~ light_gray_concrete run return run scoreboard players add #$(z)_fi dr_rim 1
$execute if score #rim_own dr_var matches 2 if block ~ ~ ~ blue_concrete run return run scoreboard players add #$(z)_fa dr_rim 1
$execute if score #rim_own dr_var matches 1 if block ~ ~ ~ lime_concrete run return run scoreboard players add #$(z)_og dr_rim 1
$execute if score #rim_own dr_var matches 1 if block ~ ~ ~ brown_concrete run return run scoreboard players add #$(z)_ow dr_rim 1
$execute if score #rim_own dr_var matches 1 if block ~ ~ ~ light_gray_concrete run return run scoreboard players add #$(z)_oi dr_rim 1
$execute if score #rim_own dr_var matches 1 if block ~ ~ ~ blue_concrete run return run scoreboard players add #$(z)_oa dr_rim 1
$execute if score #rim_own dr_var matches 0 if block ~ ~ ~ lime_concrete run return run scoreboard players add #$(z)_xg dr_rim 1
$execute if score #rim_own dr_var matches 0 if block ~ ~ ~ brown_concrete run return run scoreboard players add #$(z)_xw dr_rim 1
$execute if score #rim_own dr_var matches 0 if block ~ ~ ~ light_gray_concrete run return run scoreboard players add #$(z)_xi dr_rim 1
$execute if score #rim_own dr_var matches 0 if block ~ ~ ~ blue_concrete run return run scoreboard players add #$(z)_xa dr_rim 1
$scoreboard players add #$(z)_etc dr_rim 1
