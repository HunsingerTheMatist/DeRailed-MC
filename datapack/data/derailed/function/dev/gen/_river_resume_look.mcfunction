
# Says whether this choice still has a way untried, and leaves the reckoning of
#  it ready for whoever takes one
# Run as the note, and takes nothing further: no search starts from here

scoreboard players operation #riv_dir dr_var = @s dr_dir
execute at @s run function derailed:dev/gen/_river_look

scoreboard players operation #riv_tot dr_var = #riv_v0 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v1 dr_var
scoreboard players operation #riv_tot dr_var += #riv_v2 dr_var
execute if score #riv_tot dr_var matches 0 run return fail

scoreboard players set #riv_has dr_var 1
