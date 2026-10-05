
# Removes every train piece and its parts, the barriers over the rails under
#  each train, and the path they ran on; the shulkers go below the world first,
#  so they vanish rather than die where they stood
# Safe to call from anywhere

execute as @e[type=marker,tag=dr_reach_back] at @s summon marker run function derailed:train/_reach_unlay
execute as @e[type=shulker,tag=dr_train_part] at @s run tp @s ~ -200 ~
kill @e[tag=dr_train_part]
data remove storage derailed:train path
data remove storage derailed:train loop
