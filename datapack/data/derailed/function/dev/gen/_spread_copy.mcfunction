
# Moves the columns in 'tmp' onto the end of 'seq', in order

execute unless data storage derailed:gen tmp[0] run return 0
data modify storage derailed:gen seq append from storage derailed:gen tmp[0]
data remove storage derailed:gen tmp[0]
function derailed:dev/gen/_spread_copy
