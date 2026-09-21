
# Places one seed, giving up on it after 30 spots have all landed too close

scoreboard players set #gen_tries dr_var 30
function derailed:dev/gen/_attempt

scoreboard players remove #gen_left dr_var 1
execute if score #gen_left dr_var matches 1.. run function derailed:dev/gen/_seed
