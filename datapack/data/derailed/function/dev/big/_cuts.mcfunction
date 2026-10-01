
# Works out which way every cut that runs as river flows, run by run: from a
#  river at one end into a lake at the other, and otherwise from its western
#  end, the way the train goes, the northern end where the two ends are as far
#  west; each tile of the run flows toward the next, and the last into the
#  water it opens onto

execute as @e[type=marker,tag=dr_big_cut,distance=0..] at @s run function derailed:dev/big/_cut_ends
scoreboard players set @e[type=marker,tag=dr_big_cut,distance=0..] dr_brun 0
scoreboard players set @e[type=marker,tag=dr_big_cut,distance=0..] dr_bord 0
scoreboard players set #big_run dr_temp 0
execute as @e[type=marker,tag=dr_big_cut,distance=0..] at @s run function derailed:dev/big/_cut_group

scoreboard players set #big_r dr_temp 1
execute if score #big_run dr_temp matches 1.. run function derailed:dev/big/_cut_runs
