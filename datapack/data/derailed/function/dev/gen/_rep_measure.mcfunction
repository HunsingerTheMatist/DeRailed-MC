
# Scores the section as it stands, counting its columns and what its routes
#  need afresh, and counts how many regions of each kind with a floor it holds
# A region the supply count cannot take, one whose seed the flood never got to
#  or with more water on the way to it than the count looks past, is tagged
#  'dr_untake', since its tiles count toward the windows but not the totals
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

tag @e[type=marker,tag=dr_seed,distance=0..] remove dr_untake
tag @e[type=marker,tag=dr_seed,tag=!dr_reach,distance=0..] add dr_untake
tag @e[type=marker,tag=dr_seed,scores={dr_bridge=9..},distance=0..] add dr_untake

function derailed:dev/gen/_rep_scan
function derailed:dev/gen/_supply_count
function derailed:dev/gen/_supply_need
function derailed:dev/gen/_rep_vload
function derailed:dev/gen/_rep_eval

execute store result score #cnt_wood dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=1},distance=0..]
execute store result score #cnt_iron dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=2},distance=0..]
execute store result score #cnt_water dr_var if entity @e[type=marker,tag=dr_seed,scores={dr_kind=3},distance=0..]
