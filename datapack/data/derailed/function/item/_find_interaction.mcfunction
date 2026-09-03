# Tag the pile this player just clicked. Run as the player
#
# Args: $(UUID)

tag @e[type=interaction,distance=..10,tag=dr_resource] remove dr_current
$tag @n[type=interaction,distance=..10,tag=dr_resource,nbt={interaction:{player:$(UUID)}}] add dr_current
