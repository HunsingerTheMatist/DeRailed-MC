
# Clears what a search left behind, keeping the starts so none is tried twice
# The longest line found so far is kept as well, let go of the lattice so that
#  the next start is free to run over the corners it stands on

tag @e[type=marker,tag=dr_riv_best,distance=0..] remove dr_riv_path
kill @e[type=marker,tag=dr_riv_path,distance=0..]
kill @e[type=marker,tag=dr_riv_node,distance=0..]
kill @e[type=marker,tag=dr_riv_head,distance=0..]
