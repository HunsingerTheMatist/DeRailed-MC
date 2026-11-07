# Takes into '#night' how dark it is '#day' ticks into the day, along the fade
#  kept in the list 'list', which starts at the tick held in the constant
#  'start'

$scoreboard players operation #day dr_temp -= $(start) dr_const
execute store result storage derailed:light at.i int 1 run scoreboard players get #day dr_temp
$data modify storage derailed:light at.list set value "$(list)"
function derailed:light/_fade_at with storage derailed:light at
