
# Sends the head to the right reckoning for the way it is facing
# The column it stands in is worked out first, since a step west out of column 0
#  would carry the river back into the section before

execute store result score #riv_col dr_var run data get entity @s Pos[0] 1
scoreboard players operation #riv_col dr_var -= #gen_corner dr_var

# Whether every tile meeting this corner is bleed off the section before
# A region carried over the seam grows as the very block its kind is drawn in,
#  where one the section grew for itself grows as a block of its own, so the two
#  tell apart on sight. Bleed that came over as one kind reads as one region
#  however many it was, leaving the river nothing to follow through it
scoreboard players set #riv_bleed dr_var 1
execute unless block ~-1 ~5 ~-1 #derailed:gen_is_kind run scoreboard players set #riv_bleed dr_var 0
execute unless block ~ ~5 ~-1 #derailed:gen_is_kind run scoreboard players set #riv_bleed dr_var 0
execute unless block ~-1 ~5 ~ #derailed:gen_is_kind run scoreboard players set #riv_bleed dr_var 0
execute unless block ~ ~5 ~ #derailed:gen_is_kind run scoreboard players set #riv_bleed dr_var 0

# Whether a way on comes up against water already laid, which is the river the
#  section cut first and which the second may end in
scoreboard players set #riv_join dr_var 0

execute if score #riv_dir dr_var matches 0 run return run function derailed:dev/gen/_river_look_s
execute if score #riv_dir dr_var matches 1 run return run function derailed:dev/gen/_river_look_w
execute if score #riv_dir dr_var matches 2 run return run function derailed:dev/gen/_river_look_n
execute if score #riv_dir dr_var matches 3 run return run function derailed:dev/gen/_river_look_e
