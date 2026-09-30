
# Builds the section after the last one, all at once

scoreboard players operation #gen_corner dr_var = #gen_section dr_var
scoreboard players operation #gen_corner dr_var *= $SectionWidth dr_const
scoreboard players operation #gen_corner dr_var += #gen_origin_x dr_var
execute store result storage derailed:gen s.x int 1 run scoreboard players get #gen_corner dr_var

function derailed:dev/gen/_at_section with storage derailed:gen s
