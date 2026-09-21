
# Makes this corner the one the walk means to go to next
# Run as the tile standing at it

scoreboard players operation #riv_far dr_var = @s dr_step
scoreboard players operation #riv_bdir dr_var = #riv_try dr_var
