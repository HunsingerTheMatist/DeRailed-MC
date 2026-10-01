
# How iron rises, in pixels, sixteen to a block: every corner starts from
#  '#msmin' to '#msmax' high and no column stands lower than '#msmin' or higher
#  than '#mmax'; '#mr0' to '#mr5' are how far above its start a corner stands
#  by how many tiles in from the region's edge it is, the last for any further
#  in, and each corner gets from '#mrmin' to '#mrmax' percent of that; every
#  corner inside a region is nudged up to '#mnoise' either way, every tile's
#  nine columns together up to '#mtjit' and every column on its own up to
#  '#mjit'; up to '#mpeaks' corners two or more tiles in are raised twice
#  '#mpk' and every corner beside them '#mpk'; a tile has a '#mspk' in a
#  hundred chance of the two by two columns in one of its corners standing
#  '#mspkpx' higher; and with '#mround' set, the tiles at a corner count toward
#  depth only every other step, so the rings come out eight-sided

scoreboard players set #msmin dr_temp 21
scoreboard players set #msmax dr_temp 32
scoreboard players set #mmax dr_temp 80
scoreboard players set #mr0 dr_temp 0
scoreboard players set #mr1 dr_temp 20
scoreboard players set #mr2 dr_temp 34
scoreboard players set #mr3 dr_temp 44
scoreboard players set #mr4 dr_temp 50
scoreboard players set #mr5 dr_temp 54
scoreboard players set #mrmin dr_temp 100
scoreboard players set #mrmax dr_temp 100
scoreboard players set #mnoise dr_temp 4
scoreboard players set #mtjit dr_temp 0
scoreboard players set #mjit dr_temp 2
scoreboard players set #mpeaks dr_temp 3
scoreboard players set #mpk dr_temp 6
scoreboard players set #mspk dr_temp 0
scoreboard players set #mspkpx dr_temp 16
scoreboard players set #mround dr_temp 0
