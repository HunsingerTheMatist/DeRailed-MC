
# Makes one test run of the batch, and the next on the tick after while any
#  are left
# A scheduled function runs in the overworld, and the run clears its markers
#  in whatever dimension it is run in, so it is run in the one the test area
#  is in

execute in derailed:game run function derailed:dev/gen/test
scoreboard players remove #batch_left dr_var 1
execute if score #batch_left dr_var matches 1.. run schedule function derailed:dev/gen/_test_batch_next 1t
