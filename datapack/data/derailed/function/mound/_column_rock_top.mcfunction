
# Builds a rock column's top block, and the slab over it where it has one and
#  that is air, which leaves the station's overhang where a mound beside the
#  station reaches it
# Positioned at the top block

setblock ~ ~ ~ bedrock strict
execute if score #mcap dr_temp matches 0 if block ~ ~1 ~ air run setblock ~ ~1 ~ cobbled_deepslate_slab[type=bottom] strict
