# Put the framebuffer map back in the offhand. Run as the player
#
# TODO: the map item does not exist yet, so this is inert. Once the framebuffer
#  map is created, clear every map the player holds and place the correct one
#  into weapon.offhand. Gated behind $MapEnabled so it stays dormant until then
