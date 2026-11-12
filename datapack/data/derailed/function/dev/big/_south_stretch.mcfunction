
# Follows the river down from this tile as far as a tile already followed,
#  tagging its tiles 'dr_big_seg', and has it flow the other way where the last
#  of them is further north than this one; every tile of it is followed then
# Run as the marker of a river tile nothing flows into, at it

tag @s add dr_big_src_done
scoreboard players operation #s_r0 dr_temp = @s dr_bz
scoreboard players operation #s_r1 dr_temp = @s dr_bz
scoreboard players set #s_len dr_temp 0
function derailed:dev/big/_south_mark
execute if score #s_r1 dr_temp < #s_r0 dr_temp run function derailed:dev/big/_south_flip

tag @e[type=marker,tag=dr_big_seg,distance=0..] add dr_big_done
tag @e[type=marker,tag=dr_big_seg,distance=0..] remove dr_big_seg
tag @e[type=marker,tag=dr_big_flip,distance=0..] remove dr_big_flip
