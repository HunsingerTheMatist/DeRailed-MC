
# Lays the first piece left in 'pq' and moves on to the next
# Positioned at the section's corner

execute unless data storage derailed:gen pq[0] run return 0
function derailed:dev/gen/_piece_stamp with storage derailed:gen pq[0]
data remove storage derailed:gen pq[0]
function derailed:dev/gen/_pieces_stamp_next
