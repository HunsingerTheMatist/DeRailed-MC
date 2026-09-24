
# Swaps a region of the kind wanting in the window in from elsewhere in this
#  section: a reached region inside the window's part of this section takes
#  that kind, and a region of that kind outside the window takes the kind it
#  had, so the section keeps its mix and only the placing changes
# The region inside is of the other resource where the window has that to
#  spare, else ground, else water; never a wall, a lake, or one the first
#  route runs through
# Positioned at the section's corner

scoreboard players set #sp_spare dr_var 0
execute if score #sup_want dr_var matches 1 if score #sp_iron dr_var > #gen_spread_min dr_var run scoreboard players set #sp_spare dr_var 1
execute if score #sup_want dr_var matches 2 if score #sp_wood dr_var > #gen_spread_min dr_var run scoreboard players set #sp_spare dr_var 1
scoreboard players set #sup_other dr_var 3
scoreboard players operation #sup_other dr_var -= #sup_want dr_var

# The window's part of this section runs from the later of its start and the
#  corner to its end
scoreboard players operation #sp_cx dr_var = #sp_a dr_var
scoreboard players operation #sp_cx dr_var > #gen_cx dr_var
scoreboard players operation #sp_cdx dr_var = #sp_a dr_var
scoreboard players operation #sp_cdx dr_var += #sp_dx dr_var
scoreboard players operation #sp_cdx dr_var -= #sp_cx dr_var
execute store result storage derailed:gen w.cx int 1 run scoreboard players get #sp_cx dr_var
execute store result storage derailed:gen w.cdx int 1 run scoreboard players get #sp_cdx dr_var
tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_in
function derailed:dev/gen/_spread_in with storage derailed:gen w

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_cand
execute if score #sp_spare dr_var matches 1 as @e[type=marker,tag=dr_in,distance=0..] if score @s dr_kind = #sup_other dr_var run tag @s add dr_cand
execute unless entity @e[type=marker,tag=dr_cand,distance=0..] run tag @e[type=marker,tag=dr_in,scores={dr_kind=0},distance=0..] add dr_cand
execute unless entity @e[type=marker,tag=dr_cand,distance=0..] run tag @e[type=marker,tag=dr_in,scores={dr_kind=3},distance=0..] add dr_cand
execute unless entity @e[type=marker,tag=dr_cand,distance=0..] run return fail

execute as @e[type=marker,tag=dr_cand,distance=0..,sort=random,limit=1] run function derailed:dev/gen/_spread_swap
