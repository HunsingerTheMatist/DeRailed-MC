
# Takes the share of its rise a corner gets at random, from $(rmin) to $(rmax)
#  percent, into '#mj', or $(rmin) where the two are the same

$scoreboard players set #mj dr_var $(rmin)
$execute unless score #mj dr_var matches $(rmax) store result score #mj dr_var run random value $(rmin)..$(rmax)
