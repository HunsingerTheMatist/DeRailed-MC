
# Makes '#gen_batch_size' test runs, one a tick, each the same as running
#  'dev/gen/test' by hand, but with no armour stands over the seeds, which only
#  the last run's sections would show and every selector would have to wade
#  through; they are put back as they were once the batch is done

scoreboard players operation #batch_marks dr_var = #gen_marks dr_var
scoreboard players set #gen_marks dr_var 0
scoreboard players operation #batch_left dr_var = #gen_batch_size dr_var
function derailed:dev/gen/_test_batch_next
