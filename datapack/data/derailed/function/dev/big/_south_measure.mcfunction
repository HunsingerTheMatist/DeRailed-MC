
# Keeps in 'dr_blen' how many river tiles the river flows through from here on
# Run as the marker of a river tile nothing flows into, at it

scoreboard players set #s_len dr_temp 0
function derailed:dev/big/_south_count
scoreboard players operation @s dr_blen = #s_len dr_temp
