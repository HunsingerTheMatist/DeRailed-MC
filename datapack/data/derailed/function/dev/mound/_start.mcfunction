
# Takes a corner's start at random, from $(smin) to $(smax) pixels, into '#mj',
#  or $(smin) where the two are the same

$scoreboard players set #mj dr_var $(smin)
$execute unless score #mj dr_var matches $(smax) store result score #mj dr_var run random value $(smin)..$(smax)
