
# Adds the first section's start station's wood to column 2 of 'cols' and its
#  iron to column 3, where they are piled

execute store result score #t dr_temp run data get storage derailed:gen cols[2].w
scoreboard players operation #t dr_temp += #gen_start_wood dr_var
execute store result storage derailed:gen cols[2].w int 1 run scoreboard players get #t dr_temp
execute store result score #t dr_temp run data get storage derailed:gen cols[3].i
scoreboard players operation #t dr_temp += #gen_start_iron dr_var
execute store result storage derailed:gen cols[3].i int 1 run scoreboard players get #t dr_temp
