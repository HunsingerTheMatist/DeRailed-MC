
# Picks one of the ways on and takes it
# Straight on counts three times against a turn's one, so the river follows a
#  boundary rather than rattling along it
# Run as the head, positioned on it

scoreboard players operation #riv_a dr_var = #riv_v0 dr_var
scoreboard players operation #riv_a dr_var *= $Three dr_const
scoreboard players operation #riv_b dr_var = #riv_a dr_var
scoreboard players operation #riv_b dr_var += #riv_v1 dr_var
scoreboard players operation #riv_tot dr_var = #riv_b dr_var
scoreboard players operation #riv_tot dr_var += #riv_v2 dr_var

# 60 divides by every total the three weights can add up to, so the roll comes
#  out even however many of them are open
execute store result score #riv_r dr_var run random value 0..59
scoreboard players operation #riv_r dr_var %= #riv_tot dr_var

scoreboard players operation #riv_dir dr_var = #riv_d2 dr_var
execute if score #riv_r dr_var < #riv_b dr_var run scoreboard players operation #riv_dir dr_var = #riv_d1 dr_var
execute if score #riv_r dr_var < #riv_a dr_var run scoreboard players operation #riv_dir dr_var = #riv_d0 dr_var

function derailed:dev/gen/_river_move
