
# Keeps the run's rerolls so far, and those for too cheap and too expensive,
#  as they stand after section $(n) of a test

$scoreboard players operation #srv_r$(n) dr_var = #gen_rerolls dr_var
$scoreboard players operation #srv_c$(n) dr_var = #gen_fail_cheap dr_var
$scoreboard players operation #srv_x$(n) dr_var = #gen_fail_costly dr_var
