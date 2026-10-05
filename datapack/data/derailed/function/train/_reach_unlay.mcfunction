
# Walks this marker from where the back end of the train stands to its front
#  end clearing barriers, at most 30 blocks, then goes
# Run as a new marker, at the back end

scoreboard players operation @s dr_ai = @n[type=marker,tag=dr_reach_back,distance=0..] dr_ai
scoreboard players operation @s dr_ad = @n[type=marker,tag=dr_reach_back,distance=0..] dr_ad
scoreboard players operation @s dr_acx = @n[type=marker,tag=dr_reach_back,distance=0..] dr_acx
scoreboard players operation @s dr_acz = @n[type=marker,tag=dr_reach_back,distance=0..] dr_acz
scoreboard players operation @s dr_adin = @n[type=marker,tag=dr_reach_back,distance=0..] dr_adin
scoreboard players operation @s dr_adout = @n[type=marker,tag=dr_reach_back,distance=0..] dr_adout
scoreboard players operation @s dr_alen = @n[type=marker,tag=dr_reach_back,distance=0..] dr_alen
scoreboard players set #left dr_temp 30000
function derailed:train/_reach_unwalk
kill @s
