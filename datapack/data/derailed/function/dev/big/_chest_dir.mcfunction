
# Sends the rays out at a turn of $(yaw) from the point $(px) $(pz) across the
#  chest's block ('_chest_land'), unless the block beside the chest they leave
#  it by, $(bx) $(bz), is bedrock, which stops every one of them
# Positioned at the chest's top block

$execute if block ~$(bx) ~ ~$(bz) bedrock run return 0
$execute positioned ~$(px) 16.62 ~$(pz) run tp @n[type=marker,tag=dr_chest_walker,distance=..64] ~ ~ ~ $(yaw) 0
scoreboard players set #ch_L dr_temp 0
$function derailed:dev/big/_chest_land {px:$(px),pz:$(pz)}
