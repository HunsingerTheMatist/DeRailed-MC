
# Places the piece in 'pc', two wide and '#pc_h' tall, holding '#pc_n'
#  creatures, leaving '#pc_ok' at 1 where it found room
# Positioned at the section's corner

scoreboard players set #pc_ok dr_var 0
scoreboard players operation #pc_tries dr_var = #gen_piece_tries dr_var
function derailed:dev/gen/_piece_try
