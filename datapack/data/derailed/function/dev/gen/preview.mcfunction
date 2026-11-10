
# Shows the last section built as it looks from the section before before it
#  opens: black concrete over every tile but those the section before's regions
#  took, carried over the seam, and the yard of the station before
#  ('_preview')
# Positions itself, so it is safe to call from anywhere

scoreboard players operation #gen_corner dr_var = #gen_section dr_var
scoreboard players remove #gen_corner dr_var 1
scoreboard players operation #gen_corner dr_var *= $SectionWidth dr_const
scoreboard players operation #gen_corner dr_var += #gen_origin_x dr_var
execute store result storage derailed:gen s.x int 1 run scoreboard players get #gen_corner dr_var
function derailed:dev/gen/_preview_at with storage derailed:gen s
