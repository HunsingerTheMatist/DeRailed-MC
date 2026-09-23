
# Fills the whole of run '#cut_r' with the one terrain in '#cut_fill'

execute as @e[type=marker,tag=dr_cut,distance=0..] if score @s dr_step = #cut_r dr_var at @s run function derailed:dev/gen/_cut_fill_at
