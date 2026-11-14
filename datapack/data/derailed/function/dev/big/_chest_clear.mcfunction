
# Succeeds where a ray from a chest can pass this point: anywhere in the chest's
#  own block, and otherwise anywhere but in bedrock, the lower half of a rock
#  slab or a station's tile, so through trees, iron, cakes and the rest
# Positioned on the ray

execute align xyz if entity @e[type=marker,tag=dr_chest_self,dx=0,dy=0,dz=0] run return 1
execute if block ~ ~ ~ bedrock run return 0
execute if block ~ ~ ~ cobbled_deepslate_slab positioned ~ ~0.5 ~ if block ~ ~ ~ cobbled_deepslate_slab run return 0
execute if block ~ 1 ~ light run return 0
return 1
