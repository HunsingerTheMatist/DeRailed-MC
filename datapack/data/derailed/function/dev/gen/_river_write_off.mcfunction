
# Writes off a river tile that turned out to lead nowhere
# It keeps its path tag and stays where it is, which is what stops the head
#  trying that way again: a tile standing on a corner means that way is spent

tag @s add dr_riv_dead
scoreboard players remove #riv_len dr_var 1
scoreboard players add #riv_dead dr_var 1
