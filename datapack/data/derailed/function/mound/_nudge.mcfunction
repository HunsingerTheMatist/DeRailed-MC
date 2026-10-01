
# Takes a nudge at random into '#mj', up to '#mv' either way

scoreboard players operation #mhi dr_temp = #mv dr_temp
scoreboard players set #mlo dr_temp 0
scoreboard players operation #mlo dr_temp -= #mv dr_temp
function derailed:mound/_rand
