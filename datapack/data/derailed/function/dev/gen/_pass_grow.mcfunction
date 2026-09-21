
# Builds a run of three chained sections, then starts the next pass
# Three at a time so the seam between them is measured too, and back to the
#  start each pass so the strip stays inside the loaded area

# Each pass lays its three over the last pass's, so what they left has to go
function derailed:dev/gen/clear

scoreboard players set #gen_section dr_var 0
scoreboard players set #gen_entry dr_var 8

function derailed:dev/gen/next_section
function derailed:dev/gen/next_section
function derailed:dev/gen/next_section

scoreboard players remove #gen_pass dr_var 1
execute if score #gen_pass dr_var matches 1.. run function derailed:dev/gen/_pass_grow
