
# Stands this marker where the player is being moved to across the ground,
#  '#px' '#pz' in thousandths of a block, tagged 'dr_push_mark'
# Run as the new marker

tag @s add dr_push_mark
execute store result entity @s Pos[0] double 0.001 run scoreboard players get #px dr_temp
execute store result entity @s Pos[2] double 0.001 run scoreboard players get #pz dr_temp
