
# Drops the first '#ci_drop' columns from 'ci'

execute if score #ci_drop dr_var matches ..0 run return 0
data remove storage derailed:gen ci[0]
scoreboard players remove #ci_drop dr_var 1
function derailed:dev/gen/_carry_in_drop
