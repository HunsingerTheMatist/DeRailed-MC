
# Removes every piece of team $(team)'s train and its parts, the barriers over
#  the rails under it, and the path it ran on; the shulkers go below the world
#  first, so they vanish rather than die where they stood
# Safe to call from anywhere

$execute as @e[type=marker,tag=dr_reach_back,scores={dr_team=$(team)}] at @s summon marker run function derailed:train/_reach_unlay
$execute as @e[type=shulker,tag=dr_train_part,scores={dr_team=$(team)}] at @s run tp @s ~ -200 ~
$kill @e[tag=dr_train_part,scores={dr_team=$(team)}]
$data remove storage derailed:train t$(team).path
$data remove storage derailed:train t$(team).loop
