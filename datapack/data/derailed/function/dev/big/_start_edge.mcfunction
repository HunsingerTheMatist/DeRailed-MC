
# Takes the rock's slabs off at y18 and stands upright the iron at y17 along
#  the start station's northern and eastern edges, where the mounds went up
#  over its overhang
# Positioned at the start station's northeastern corner

fill ~-6 18 ~ ~-1 18 ~ air replace cobbled_deepslate_slab strict
fill ~ 18 ~1 ~ 18 ~3 air replace cobbled_deepslate_slab strict
fill ~-6 17 ~ ~-1 17 ~ basalt[axis=y] replace basalt strict
fill ~ 17 ~1 ~ 17 ~3 basalt[axis=y] replace basalt strict
