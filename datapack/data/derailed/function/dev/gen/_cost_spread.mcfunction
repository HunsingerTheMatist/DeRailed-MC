
# Spreads from this tile onto the four next to it that nothing has reached yet,
#  then retires the marker
# Run as the marker, positioned on it
# A tile off the edge of the section reads as reached, since the ring laid round
#  the section counts as seen

execute if score #gen_reached dr_var matches 1 run return 0
execute if score #order_on dr_var matches 1 run function derailed:dev/gen/_order_at

execute positioned ~1 ~ ~ unless block ~ ~2 ~ #derailed:flood_visited run function derailed:dev/gen/_cost_e
execute positioned ~-1 ~ ~ unless block ~ ~2 ~ #derailed:flood_visited run function derailed:dev/gen/_cost_w
execute positioned ~ ~ ~1 unless block ~ ~2 ~ #derailed:flood_visited run function derailed:dev/gen/_cost_s
execute positioned ~ ~ ~-1 unless block ~ ~2 ~ #derailed:flood_visited run function derailed:dev/gen/_cost_n

scoreboard players remove #cost_pending dr_var 1
kill @s
