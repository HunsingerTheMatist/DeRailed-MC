
# Keeps this note's wave if it beats the earliest seen so far

execute if score @s dr_kind matches 0.. if score @s dr_wave < #seam_min dr_var run scoreboard players operation #seam_min dr_var = @s dr_wave
