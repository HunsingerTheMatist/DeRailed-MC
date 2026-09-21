
# Takes this spot for a seed unless another seed is already close

# The spacing is what keeps the regions an even size, so nothing has to relax
#  them afterwards - and loosening it is the knob for the opposite, since seeds
#  that are free to cluster grow regions of uneven size and shape
scoreboard players set #gen_ok dr_var 0
execute store result storage derailed:gen d.r int 1 run scoreboard players get #gen_spacing dr_var
function derailed:dev/gen/_place_at with storage derailed:gen d
