
# Takes how many peaks into '#mp' at random, from one to $(peaks), or $(peaks)
#  where that is one or none

$scoreboard players set #mp dr_var $(peaks)
$execute unless score #mp dr_var matches ..1 store result score #mp dr_var run random value 1..$(peaks)
