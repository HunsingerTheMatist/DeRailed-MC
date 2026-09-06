# Tag the placement this player just clicked. Run as the player
#
# Args: $(UUID)

tag @e[type=interaction,distance=..10] remove dr_current
$tag @n[type=interaction,distance=..10,nbt={interaction:{player:$(UUID)}}] add dr_current
