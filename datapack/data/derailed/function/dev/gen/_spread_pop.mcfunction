
# Drops the oldest column from the window and from its running totals

execute store result score #sp_c dr_var run data get storage derailed:gen fifo[0].w
scoreboard players operation #sp_wood dr_var -= #sp_c dr_var
execute store result score #sp_c dr_var run data get storage derailed:gen fifo[0].i
scoreboard players operation #sp_iron dr_var -= #sp_c dr_var
data remove storage derailed:gen fifo[0]
