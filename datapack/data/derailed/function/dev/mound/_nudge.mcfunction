
# Takes a nudge into '#mj' at random, up to $(v) either way, or none where $(v)
#  is nothing

scoreboard players set #mj dr_var 0
$execute unless score #mj dr_var matches $(v) store result score #mj dr_var run random value -$(v)..$(v)
