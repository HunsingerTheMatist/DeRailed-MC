
# Makes '#gen_batch_size' test runs, one a tick, each the same as running
#  'dev/gen/test' by hand

scoreboard players operation #batch_left dr_var = #gen_batch_size dr_var
function derailed:dev/gen/_test_batch_next
