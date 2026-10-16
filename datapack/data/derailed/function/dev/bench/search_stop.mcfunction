# Lets the game tick run again after a pile search bench, and says it finished

scoreboard players set #bench dr_var 0
scoreboard players set #bench_search dr_var 0
tellraw @a [{text:"[bench] search done",color:"gray"}]
