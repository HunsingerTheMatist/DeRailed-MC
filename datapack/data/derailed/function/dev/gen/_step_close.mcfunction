
# Is done with the section: hands its exit row on as the next entry row, which
#  is what keeps the track continuous across the boundary

scoreboard players add #gen_section dr_var 1
scoreboard players operation #gen_entry dr_var = #gen_exit dr_var
scoreboard players set #q_step dr_var 0
return 1
