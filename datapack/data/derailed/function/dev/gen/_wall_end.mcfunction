
# Runs the band straight south from here to the border, so that it ends on the
#  edge rather than a row or two short of it
# Positioned on the band's last seed, with '#wall_lx' and '#wall_lz' where
#  that is

scoreboard players operation #wall_tx dr_var = #wall_lx dr_var
scoreboard players operation #wall_tz dr_var = #gen_cz dr_var
scoreboard players add #wall_tz dr_var 15
function derailed:dev/gen/_wall_line
