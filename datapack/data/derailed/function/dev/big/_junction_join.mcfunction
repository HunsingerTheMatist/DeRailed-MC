
# Has the river tile here feed this one, flowing $(way) into it: the tile here
#  leaves that way as well as its own, 'dr_big_out_$(way)', and this one is fed
#  flowing that way, a bend where it flows another
# Run as the marker of the tile being fed, at the tile feeding it

$tag @e[type=marker,tag=dr_big_river,distance=..0.5] add dr_big_out_$(way)
$tag @s add dr_big_in_$(way)
$execute unless entity @s[tag=dr_big_$(way)] run tag @s add dr_big_feed_$(way)
