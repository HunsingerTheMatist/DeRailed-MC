
# Takes the rock's slabs off at y18 and stands upright the iron at y17 along
#  the station's northern and western edges, where the mounds went up over its
#  overhang
# Positioned at the station's northwestern corner

fill ~1 18 ~ ~6 18 ~ air replace cobbled_deepslate_slab strict
fill ~ 18 ~1 ~ 18 ~3 air replace cobbled_deepslate_slab strict
fill ~1 17 ~ ~6 17 ~ basalt[axis=y] replace basalt strict
fill ~ 17 ~1 ~ 17 ~3 basalt[axis=y] replace basalt strict
