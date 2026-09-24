
# Repaints this seed's region as the kind in '#sup_want', on the visible layer
#  and the kinds layer both, leaving the river where it runs over the region,
#  and puts magenta glass over it so the repainting can be picked out from
#  above
# Run as the seed, positioned at the section's corner

scoreboard players operation @s dr_kind = #sup_want dr_var
tag @s remove dr_supply
execute if score #sup_want dr_var matches 1..2 run tag @s add dr_supply
execute store result storage derailed:gen p.n int 1 run scoreboard players get @s dr_id
execute store result storage derailed:gen p.k int 1 run scoreboard players get #sup_want dr_var
function derailed:dev/gen/_paint_pick with storage derailed:gen p
scoreboard players set #each_z dr_var 0
function derailed:dev/gen/_repaint_row
scoreboard players add #gen_repainted dr_var 1

# A region that was water needs no bridge to itself now, and one that has
#  become water is a bridge to cross, so the water on the way to it is counted
#  again
execute at @s positioned ~ ~15 ~ run function derailed:dev/gen/_supply_seed
