
# Finishes the section once an attempt has passed or the last has been made:
#  the run's totals, what the section after reads, the report's looks, and the
#  ring round the section taken up
# Positioned at the section's corner

# Whether there is enough wood and iron within reach to lay either route, for
#  a section that ships without its last attempt having got as far as asking
execute if score #sup_done dr_var matches 0 positioned ~ ~15 ~ run function derailed:dev/gen/supply

# The river running along a lake's shore joins the lake, before anything reads
#  the section as it ships
execute positioned ~ ~15 ~ run function derailed:dev/gen/lakeside

# Only the attempt that ships counts toward the run's totals, and only its
#  columns are handed on to the section after
scoreboard players operation #gen_tail_gaps dr_var += #gen_tail_gap dr_var
scoreboard players operation #gen_spread_total dr_var += #gen_spread_gaps dr_var
execute if score #sup_short dr_var matches 1 run scoreboard players add #gen_supply_short dr_var 1
scoreboard players operation #gen_repaints dr_var += #gen_repainted dr_var
scoreboard players operation #gen_repair_swaps_total dr_var += #gen_repair_swaps dr_var
scoreboard players operation #gen_repair_paints_total dr_var += #gen_repair_paints dr_var
data modify storage derailed:gen prev_cols set from storage derailed:gen sec_cols
scoreboard players operation #gen_pieces_placed dr_var += #piece_cows dr_var
scoreboard players operation #gen_pieces_placed dr_var += #piece_bandits dr_var
scoreboard players operation #gen_pieces_dropped dr_var += #piece_lost dr_var
scoreboard players operation #gen_order_fixed dr_var += #ofixed dr_var

# A piece the section ships without has black glass on its northwestern tile
execute as @e[type=marker,tag=dr_piece,tag=dr_dropped,dx=31,dy=0,dz=15] at @s run setblock ~ ~16 ~ black_stained_glass strict

# For the report, once, on the section as it ships: what each route costs to
#  lay across it, priced the way the flood prices the first, and what the tiles
#  either side of its western seam are
scoreboard players set #price_first dr_var 0
scoreboard players set #price_second dr_var 0
execute if score #gen_report dr_var matches 1 if score #sec_reached dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_price_routes
execute if score #gen_report dr_var matches 1 positioned ~ ~15 ~ run function derailed:dev/gen/_rim_look

# The ring the attempts laid round the section goes, since the sections either
#  side have their own tiles there
fill ~-1 ~18 ~-1 ~-1 ~18 ~16 air replace tinted_glass strict
fill ~32 ~18 ~-1 ~32 ~18 ~16 air replace tinted_glass strict
fill ~-1 ~18 ~-1 ~32 ~18 ~-1 air replace tinted_glass strict
fill ~-1 ~18 ~16 ~32 ~18 ~16 air replace tinted_glass strict

# The notes left along the eastern edge only learn their kind once the section is
#  settled, since a reroll would have changed it under them
execute as @e[type=marker,tag=dr_edge,tag=!dr_prefab,distance=0..] at @s positioned ~ ~15 ~ run function derailed:dev/gen/_edge_kind

function derailed:dev/gen/_step_close
return 1
