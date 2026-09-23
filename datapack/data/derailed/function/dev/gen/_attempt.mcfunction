
# Rolls a spot for one seed and tries again while it keeps landing too close

# Only the westmost column is left clear, which is the one the seam plants into:
#  a seed there would keep its own tile and the row it sits on would carry
#  nothing over
# Keeping more of them clear reserves that whole strip for the carried regions,
#  since nothing else can reach it, and the edge of the reservation comes out as
#  a straight line down the section
execute store result storage derailed:gen s.x int 1 run random value 1..31
execute store result storage derailed:gen s.z int 1 run random value 0..15
function derailed:dev/gen/_try with storage derailed:gen s

scoreboard players remove #gen_tries dr_var 1
execute if score #gen_ok dr_var matches 0 if score #gen_tries dr_var matches 1.. run function derailed:dev/gen/_attempt
