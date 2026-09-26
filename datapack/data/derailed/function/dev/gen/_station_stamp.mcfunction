
# Lays the station's tiles on the layer the regions grow on, in blocks of its
#  own that nothing grows into, cuts or paints: bedrock for its ground, the
#  rail row, the tile above its buffer stop, the two rows below it and the
#  yard, all of it open to the players and the track alike, and obsidian for
#  the building above its first two rails, which nothing crosses
# The yard on this side of the seam belongs to the station of the section
#  before, on that section's rail row, which is this section's entry row; the
#  first section has the same yard at its entry, with no station before it
# Takes the rows from 'r': $(exit), $(top), $(low), $(foot), $(entry),
#  $(yup), $(ydown)
# Positioned at the section's corner

$fill ~28 ~ ~$(exit) ~31 ~ ~$(exit) bedrock strict
$fill ~29 ~ ~$(top) ~30 ~ ~$(top) obsidian strict
$setblock ~31 ~ ~$(top) bedrock strict
$fill ~29 ~ ~$(low) ~31 ~ ~$(foot) bedrock strict
$setblock ~ ~ ~$(yup) bedrock strict
$fill ~ ~ ~$(entry) ~1 ~ ~$(entry) bedrock strict
$setblock ~ ~ ~$(ydown) bedrock strict
