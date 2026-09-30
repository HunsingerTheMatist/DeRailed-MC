
# Adds the wood of every column left in 'ci' to '#gen_carry_in'

execute unless data storage derailed:gen ci[0] run return 0
execute store result score #ci_w dr_var run data get storage derailed:gen ci[0].w
scoreboard players operation #gen_carry_in dr_var += #ci_w dr_var
data remove storage derailed:gen ci[0]
function derailed:dev/gen/_carry_in_add
