
# Prints the terrain either side of the first seam, row by row, so it can be read
#  back out of the game's log rather than looked at
# Columns run from two tiles inside the section before to three inside this one
# Kinds are 0 ground, 1 wood, 2 iron, 3 water, 4 rock, and -1 anything else,
#  which on finished terrain means the river

scoreboard players operation #gen_corner dr_var = #gen_origin_x dr_var
scoreboard players operation #gen_corner dr_var += $SectionWidth dr_const
execute store result storage derailed:gen s.x int 1 run scoreboard players get #gen_corner dr_var

tellraw @a [{text:"[dump] seam at the second section, columns -2 to 3",color:"gray"}]
function derailed:dev/gen/_dump_at with storage derailed:gen s
