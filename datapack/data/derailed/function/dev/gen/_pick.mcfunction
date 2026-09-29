
# Tags 'dr_picked' one of the markers tagged 'dr_pickc', taken at random from
#  the generator's own random sequence, and takes 'dr_pickc' off them all

tag @e[type=marker,tag=dr_picked,distance=0..] remove dr_picked
execute store result score #pick_n dr_var if entity @e[type=marker,tag=dr_pickc,distance=0..]
execute if score #pick_n dr_var matches 0 run return 0
execute store result score #pick dr_var run random value 0..2147483646 derailed:gen
scoreboard players operation #pick dr_var %= #pick_n dr_var
execute as @e[type=marker,tag=dr_pickc,distance=0..] run function derailed:dev/gen/_pick_count
tag @e[type=marker,tag=dr_pickc,distance=0..] remove dr_pickc
