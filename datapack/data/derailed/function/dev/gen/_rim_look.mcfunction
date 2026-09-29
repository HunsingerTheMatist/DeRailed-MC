
# Counts what every tile of the section's first ten columns, zone 'a', and its
#  last ten, zone 'b', is into 'dr_rim', for the report, tagging the regions
#  the first route runs through 'dr_rimf' first
# Positioned at the section's corner, on the visible layer, with the routes
#  drawn two above

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_rimf
data modify storage derailed:gen e.f set value "_rim_first_at"
function derailed:dev/gen/_each

function derailed:dev/gen/_rim_zero {z:a}
function derailed:dev/gen/_rim_zero {z:b}
scoreboard players set #rim_n dr_var 0
function derailed:dev/gen/_rim_col {z:a}
scoreboard players set #rim_n dr_var 0
execute positioned ~22 ~ ~ run function derailed:dev/gen/_rim_col {z:b}
