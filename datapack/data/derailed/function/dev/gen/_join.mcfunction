
# Puts this seed on the chain as its newest end, and carries on forward from it

tag @e[type=marker,tag=dr_head,distance=0..] remove dr_head
tag @s add dr_chain
tag @s add dr_head
function derailed:dev/gen/_walk
