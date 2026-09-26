
# Drops '#sp_drop' columns from the front of 'seq', the ones of the section
#  before that lie west of the first window

execute if score #sp_drop dr_var matches ..0 run return 0
data remove storage derailed:gen seq[0]
scoreboard players remove #sp_drop dr_var 1
function derailed:dev/gen/_spread_drop
