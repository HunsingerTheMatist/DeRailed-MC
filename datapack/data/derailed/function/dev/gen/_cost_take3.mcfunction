
# Puts this tile on the wave its cost falls due for the supply check: one for
#  water, the bridge it takes, nothing for anything else, and rock is never
#  stepped onto at all
# Positioned on the tile

execute if block ~ ~ ~ gray_concrete run return 0

# 'derailed:gen/cost_tag_supply' is the wave it falls due on, eight waves to a
#  tag
execute store result storage derailed:gen c.w int 1 run compute block ~ ~ ~ integer derailed:gen/cost_tag_supply
function derailed:dev/gen/_cost_summon with storage derailed:gen c
scoreboard players add #cost_pending dr_var 1
