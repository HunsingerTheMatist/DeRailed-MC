
# Builds a column of $(k) whole blocks of $(full), the top one, $(k1) up, made
#  $(top), with $(cap) over them where the column has a slab
# Positioned at the column's foot

$fill ~ ~ ~ ~ ~$(k1) ~ $(full) strict
$setblock ~ ~$(k1) ~ $(top) strict
$execute if score #mcap dr_var matches 0.. run setblock ~ ~$(k) ~ $(cap) strict
