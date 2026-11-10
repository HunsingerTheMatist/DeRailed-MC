
# Draws the station as it is meant to be seen: ground along the rail row, the
#  yard, the tile above the buffer stop and the two rows below the rail, rock
#  across the building, with rails and a buffer stop at the end of the track
#  over the rail row and bricks over the building a layer up, where the marks
#  are kept; in the first section the start station too, its buffer stop and
#  seven rails along its rail row and bricks over its building
# Takes the rows from 'r'
# Positioned at the section's corner, on the visible layer

$fill ~28 ~ ~$(exit) ~31 ~ ~$(exit) lime_concrete strict
$fill ~29 ~ ~$(top) ~30 ~ ~$(top) gray_concrete strict
$setblock ~31 ~ ~$(top) lime_concrete strict
$fill ~29 ~ ~$(low) ~31 ~ ~$(foot) lime_concrete strict
$fill ~29 ~1 ~$(exit) ~30 ~1 ~$(exit) rail[shape=east_west] strict
$setblock ~31 ~1 ~$(exit) oak_fence strict
$fill ~29 ~1 ~$(top) ~30 ~1 ~$(top) bricks strict
$setblock ~ ~ ~$(yup) lime_concrete strict
$fill ~ ~ ~$(entry) ~1 ~ ~$(entry) lime_concrete strict
$setblock ~ ~ ~$(ydown) lime_concrete strict
$execute if score #gen_section dr_var matches 0 run fill ~ ~ ~$(yup) ~9 ~ ~$(sfoot) lime_concrete strict
$execute if score #gen_section dr_var matches 0 run fill ~1 ~ ~$(yup) ~2 ~ ~$(yup) gray_concrete strict
$execute if score #gen_section dr_var matches 0 run setblock ~ ~1 ~$(entry) oak_fence strict
$execute if score #gen_section dr_var matches 0 run fill ~1 ~1 ~$(entry) ~7 ~1 ~$(entry) rail[shape=east_west] strict
$execute if score #gen_section dr_var matches 0 run fill ~1 ~1 ~$(yup) ~2 ~1 ~$(yup) bricks strict
