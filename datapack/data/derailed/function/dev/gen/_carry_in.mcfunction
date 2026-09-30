
# Counts into '#gen_carry_in' the wood tiles within reach in the section
#  before's last '#gen_water_reach' columns, as it stored them in 'prev_cols',
#  which is what the players can bring over the seam with them; nothing for the
#  first section

scoreboard players set #gen_carry_in dr_var 0
execute if score #gen_section dr_var matches 0 run return 0
data modify storage derailed:gen ci set from storage derailed:gen prev_cols
scoreboard players operation #ci_drop dr_var = $SectionWidth dr_const
scoreboard players operation #ci_drop dr_var -= #gen_water_reach dr_var
function derailed:dev/gen/_carry_in_drop
function derailed:dev/gen/_carry_in_add
