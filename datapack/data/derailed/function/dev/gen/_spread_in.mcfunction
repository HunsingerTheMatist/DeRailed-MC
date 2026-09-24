
# Puts up every region of this section that may be repainted whose seed lies
#  between column $(cx) and $(cdx) columns past it, on the rows from $(z) down

$tag @e[type=marker,tag=dr_seed,tag=dr_reach,tag=!dr_wall,tag=!dr_lake,tag=!dr_on_first,x=$(cx),dx=$(cdx),y=-64,dy=384,z=$(z),dz=15] add dr_in
