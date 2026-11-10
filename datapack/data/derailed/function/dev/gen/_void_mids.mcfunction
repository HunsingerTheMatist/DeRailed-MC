
# Marks where each of the void's three starts stands, row '#void_a' of the
#  column '#void_ka' tiles west of the first and so on, with a marker tagged
#  'dr_void_mid'
# Positioned at the section's corner, which stands at z 0

execute store result storage derailed:gen v.k int 1 run scoreboard players get #void_ka dr_var
execute store result storage derailed:gen v.z int 1 run scoreboard players get #void_a dr_var
function derailed:dev/gen/_void_mid with storage derailed:gen v
execute store result storage derailed:gen v.k int 1 run scoreboard players get #void_kb dr_var
execute store result storage derailed:gen v.z int 1 run scoreboard players get #void_b dr_var
function derailed:dev/gen/_void_mid with storage derailed:gen v
execute store result storage derailed:gen v.k int 1 run scoreboard players get #void_kc dr_var
execute store result storage derailed:gen v.z int 1 run scoreboard players get #void_c dr_var
function derailed:dev/gen/_void_mid with storage derailed:gen v
