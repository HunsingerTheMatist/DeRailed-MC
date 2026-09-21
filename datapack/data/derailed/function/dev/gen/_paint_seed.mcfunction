
# Paints this seed's region in its kind
# Run as the seed, positioned at the section's corner

execute store result storage derailed:gen p.n int 1 run scoreboard players get @s dr_id
execute store result storage derailed:gen p.k int 1 run scoreboard players get @s dr_kind

function derailed:dev/gen/_paint_pick with storage derailed:gen p
function derailed:dev/gen/_paint_fill with storage derailed:gen p
