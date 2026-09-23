
# Notes a route tile that is not rock: it closes any run of rock the trace was
#  in, as that run's end on the entry side, and is what the next run's exit end
#  will be
# Positioned on the tile

function derailed:dev/gen/_cut_kind
execute if score #cut_open dr_var matches 1 run function derailed:dev/gen/_cut_close
scoreboard players operation #cut_last dr_var = #cut_k dr_var
