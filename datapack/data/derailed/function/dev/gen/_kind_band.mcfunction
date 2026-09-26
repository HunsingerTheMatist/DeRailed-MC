
# Gives '#pl_kind' to one seed in band '#pl_k' of '#pl_bands', then moves on to
#  the next band
# A band runs from the width times its number over the bands to one short of
#  where the next starts
# Positioned at the section's corner

execute if score #pl_k dr_var >= #pl_bands dr_var run return 0

scoreboard players operation #pl_a dr_var = $SectionWidth dr_const
scoreboard players operation #pl_a dr_var *= #pl_k dr_var
scoreboard players operation #pl_a dr_var /= #pl_bands dr_var
scoreboard players operation #pl_b dr_var = #pl_k dr_var
scoreboard players add #pl_b dr_var 1
scoreboard players operation #pl_b dr_var *= $SectionWidth dr_const
scoreboard players operation #pl_b dr_var /= #pl_bands dr_var
scoreboard players remove #pl_b dr_var 1

scoreboard players operation #pl_dx dr_var = #pl_b dr_var
scoreboard players operation #pl_dx dr_var -= #pl_a dr_var
scoreboard players operation #pl_mx dr_var = #pl_dx dr_var
scoreboard players operation #pl_mx dr_var /= $Two dr_const
scoreboard players operation #pl_mx dr_var += #pl_a dr_var
scoreboard players operation #pl_mx dr_var += #gen_cx dr_var
scoreboard players operation #pl_a dr_var += #gen_cx dr_var
execute store result storage derailed:gen p.x int 1 run scoreboard players get #pl_a dr_var
execute store result storage derailed:gen p.dx int 1 run scoreboard players get #pl_dx dr_var
execute store result storage derailed:gen p.mx int 1 run scoreboard players get #pl_mx dr_var
function derailed:dev/gen/_kind_band_at with storage derailed:gen p

scoreboard players add #pl_k dr_var 1
function derailed:dev/gen/_kind_band
