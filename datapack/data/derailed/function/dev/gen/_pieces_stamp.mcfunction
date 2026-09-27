
# Lays every piece in 'pieces' on the layer the regions grow on again
# Positioned at the section's corner

data modify storage derailed:gen pq set from storage derailed:gen pieces
function derailed:dev/gen/_pieces_stamp_next
