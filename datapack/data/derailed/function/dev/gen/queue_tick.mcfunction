
# Runs the section queue for a tick while it is on: starts the next section
#  asked for once the last is done, then runs one step of the section being
#  built, and any after it that find nothing to do, so that no tick takes more
#  than one step's work

execute unless score #q_on dr_var matches 1 run return 0

# With '#q_gap' at 1 it works only every other tick, so that each tick's work
#  stands between idle ticks when the ticks are timed
execute if score #q_gap dr_var matches 1 run scoreboard players add #q_flip dr_var 1
execute if score #q_gap dr_var matches 1 if score #q_flip dr_var matches 2.. run scoreboard players set #q_flip dr_var 0
execute if score #q_gap dr_var matches 1 if score #q_flip dr_var matches 1 run return 0

execute if score #q_step dr_var matches 0 run function derailed:dev/gen/_q_next
execute unless score #q_step dr_var matches 1.. run return 0
execute if score #q_log dr_var matches 1 run tellraw @a [{text:"[q] section ",color:"gray"},{score:{name:"#gen_section",objective:"dr_var"}},"   step ",{score:{name:"#q_step",objective:"dr_var"}}]
function derailed:dev/gen/_q_here with storage derailed:gen q
