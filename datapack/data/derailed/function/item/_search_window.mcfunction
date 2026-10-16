# Works out how far the map reaches from this block across, for the search's
#  lines to check their blocks against, '#sx0' to '#sx1' from '$MapMinX' to
#  '$MapMaxX' and '#sz0' to '#sz1' from '$MapMinZ' to '$MapMaxZ', and how far
#  its lowest is from this block, '#sy0' from '$MapMinY', for the search to
#  pick its list by
# Run at the bottom middle of the block the search starts from

execute summon marker run function derailed:item/_search_origin
scoreboard players operation #sx0 dr_temp = $MapMinX dr_var
scoreboard players operation #sx0 dr_temp -= #ox dr_temp
scoreboard players operation #sx1 dr_temp = $MapMaxX dr_var
scoreboard players operation #sx1 dr_temp -= #ox dr_temp
scoreboard players operation #sy0 dr_temp = $MapMinY dr_var
scoreboard players operation #sy0 dr_temp -= #oy dr_temp
scoreboard players operation #sz0 dr_temp = $MapMinZ dr_var
scoreboard players operation #sz0 dr_temp -= #oz dr_temp
scoreboard players operation #sz1 dr_temp = $MapMaxZ dr_var
scoreboard players operation #sz1 dr_temp -= #oz dr_temp
