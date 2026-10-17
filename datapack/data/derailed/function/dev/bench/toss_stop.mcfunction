# Removes the thrown piles 'dev/bench/toss' left, lets the game tick run again,
#  and says it finished

execute in derailed:game as @e[type=item_display,tag=dr_toss,distance=0..] run function derailed:toss/_remove
scoreboard players set #bench dr_var 0
tellraw @a [{text:"[bench] toss done",color:"gray"}]
