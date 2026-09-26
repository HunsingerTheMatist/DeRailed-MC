
# Counts the window just filled as wanting, and adds it to 'spread_gaps' as the
#  column of this section it ends on and the wood and iron tiles it holds

scoreboard players add #gen_spread_gaps dr_var 1
execute store result storage derailed:gen gap.c int 1 run scoreboard players get #sp_col dr_var
execute store result storage derailed:gen gap.w int 1 run scoreboard players get #sp_wood dr_var
execute store result storage derailed:gen gap.i int 1 run scoreboard players get #sp_iron dr_var
data modify storage derailed:gen spread_gaps append from storage derailed:gen gap
