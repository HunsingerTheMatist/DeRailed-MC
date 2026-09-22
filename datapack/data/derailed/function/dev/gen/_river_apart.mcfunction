
# Says in '#riv_apart' whether the column rolled for a start is far enough from
#  the one the river before set out from, which is what keeps the second river
#  from setting out beside the first and running into it at once

scoreboard players operation #riv_span dr_var = #riv_col_try dr_var
scoreboard players operation #riv_span dr_var -= #riv_col1 dr_var
execute if score #riv_span dr_var matches ..-1 run scoreboard players operation #riv_span dr_var *= $NegOne dr_const

scoreboard players set #riv_apart dr_var 0
execute if score #riv_span dr_var >= #gen_riv_apart dr_var run scoreboard players set #riv_apart dr_var 1
