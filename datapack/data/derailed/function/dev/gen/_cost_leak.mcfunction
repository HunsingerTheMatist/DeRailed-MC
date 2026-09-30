
# Stops a flood that has more tiles waiting than a section holds, which only a
#  flood got out past its ring can have, before it spreads over the world, and
#  says so in chat
# The markers it leaves go with the rest of the flood's

scoreboard players set #cost_pending dr_var 0
scoreboard players set #cost_waiting dr_var 0
scoreboard players set #cost_next dr_var 0
scoreboard players add #gen_leaks dr_var 1
tellraw @a {text:"[gen] a flood got out of its section and was stopped; the ring round the section has a hole",color:"red"}
