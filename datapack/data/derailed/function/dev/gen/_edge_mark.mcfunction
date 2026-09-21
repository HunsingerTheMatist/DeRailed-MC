
# Records when this tile was taken
# Run as the marker just summoned on it

tag @s add dr_edge
scoreboard players operation @s dr_wave = #gen_wave dr_var

# The kind waits until the section settles, and staying unset means a section
#  that never did is not carried over
scoreboard players set @s dr_kind -1
