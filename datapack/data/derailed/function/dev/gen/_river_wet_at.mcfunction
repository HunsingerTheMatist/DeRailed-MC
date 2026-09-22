
# Lays water on this corner, or on the way the search went where that is what is
#  being looked at
# Run as the corner's marker, positioned on it

# A corner on the southern border stands outside the section: nothing is laid
#  there, which is what keeps a section to its own ground
# Whether the corner is inside at all is asked of the base, while the water goes
#  on the copy the river is cut into
execute if block ~ ~ ~ air run return fail

# The glaze is laid facing back the way the head came, which is the way round the
#  arrow on it reads, and it is swapped for plain water on the way up to the
#  finished section
execute if score @s dr_dir matches 0 run return run setblock ~ ~9 ~ magenta_glazed_terracotta[facing=north] strict
execute if score @s dr_dir matches 1 run return run setblock ~ ~9 ~ magenta_glazed_terracotta[facing=east] strict
execute if score @s dr_dir matches 2 run return run setblock ~ ~9 ~ magenta_glazed_terracotta[facing=south] strict
setblock ~ ~9 ~ magenta_glazed_terracotta[facing=west] strict
