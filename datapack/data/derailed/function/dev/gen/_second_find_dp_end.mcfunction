
# Ends working out the second way once the stretches are settled, and returns 1
#  where there is one; where there is none, leaves '#gen_reached' at 0
# Positioned at the section's corner

kill @e[type=marker,tag=dr_bq,distance=0..]

# The ways the searches kept are cleared once the way is laid, or at once
#  where there is none
scoreboard players operation #sec_y dr_var = #sec_last dr_var
scoreboard players add #sec_y dr_var 6
execute store result storage derailed:gen sk.top int 1 run scoreboard players get #sec_y dr_var

fill ~ ~2 ~ ~31 ~2 ~15 air strict
execute if score #sec_found dr_var matches 0 if score #sec_last dr_var matches 0.. run function derailed:dev/gen/_sec_keep_clear with storage derailed:gen sk
execute if score #sec_found dr_var matches 0 run scoreboard players set #gen_reached dr_var 0
execute if score #sec_found dr_var matches 0 run return 0
return 1
