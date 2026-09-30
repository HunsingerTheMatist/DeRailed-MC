
# Runs step '#q_step' of the section being built, which leaves '#q_step' at the
#  step after it, or at 0 once the section is done, and returns 1 where the
#  step did any real work and 0 where it found nothing to do
# Positioned at the section's corner

execute if score #q_step dr_var matches 40 run return run function derailed:dev/gen/_step_relief
execute if score #q_step dr_var matches 10 run return run function derailed:dev/gen/_step_paint
execute if score #q_step dr_var matches 41 run return run function derailed:dev/gen/_step_validate
execute if score #q_step dr_var matches 42 run return run function derailed:dev/gen/_step_validate_b
execute if score #q_step dr_var matches 43 run return run function derailed:dev/gen/_step_sec_a
execute if score #q_step dr_var matches 44 run return run function derailed:dev/gen/_step_sec_search
execute if score #q_step dr_var matches 51 run return run function derailed:dev/gen/_step_sec_refind
execute if score #q_step dr_var matches 45 run return run function derailed:dev/gen/_step_sec_search_b
execute if score #q_step dr_var matches 46 run return run function derailed:dev/gen/_step_sec_b
execute if score #q_step dr_var matches 47 run return run function derailed:dev/gen/_step_sec_after
execute if score #q_step dr_var matches 48 run return run function derailed:dev/gen/_step_retry
execute if score #q_step dr_var matches 50 run return run function derailed:dev/gen/_step_retry_b
execute if score #q_step dr_var matches 49 run return run function derailed:dev/gen/_step_sec_end
execute if score #q_step dr_var matches 11 run return run function derailed:dev/gen/_step_order_pre
execute if score #q_step dr_var matches 12 run return run function derailed:dev/gen/_step_second
execute if score #q_step dr_var matches 13 run return run function derailed:dev/gen/_step_cheapest
execute if score #q_step dr_var matches 14 run return run function derailed:dev/gen/_step_supply
execute if score #q_step dr_var matches 15 run return run function derailed:dev/gen/_step_order
execute if score #q_step dr_var matches 16 run return run function derailed:dev/gen/_step_judge
execute if score #q_step dr_var matches 31 run return run function derailed:dev/gen/_step_sup_rep
execute if score #q_step dr_var matches 36 run return run function derailed:dev/gen/_step_sup_rep_iron
execute if score #q_step dr_var matches 53 run return run function derailed:dev/gen/_step_validate_carve
execute if score #q_step dr_var matches 52 run return run function derailed:dev/gen/_step_rivers_b
execute if score #q_step dr_var matches 54 run return run function derailed:dev/gen/_step_river_walk
execute if score #q_step dr_var matches 55 run return run function derailed:dev/gen/_step_rivers_a_end
execute if score #q_step dr_var matches 56 run return run function derailed:dev/gen/_step_rivers_b_end
execute if score #q_step dr_var matches 30 run return run function derailed:dev/gen/_step_sup_a
execute if score #q_step dr_var matches 32 run return run function derailed:dev/gen/_step_sup_c
execute if score #q_step dr_var matches 37 run return run function derailed:dev/gen/_step_sup_d
execute if score #q_step dr_var matches 60 run return run function derailed:dev/gen/_step_find
execute if score #q_step dr_var matches 61 run return run function derailed:dev/gen/_step_find_resume
execute if score #q_step dr_var matches 62 run return run function derailed:dev/gen/_step_find_lay
execute if score #q_step dr_var matches 63 run return run function derailed:dev/gen/_step_sec_refind_end
execute if score #q_step dr_var matches 33 run return run function derailed:dev/gen/_step_order_fix
execute if score #q_step dr_var matches 34 run return run function derailed:dev/gen/_step_order_again
execute if score #q_step dr_var matches 35 run return run function derailed:dev/gen/_step_order_end
execute if score #q_step dr_var matches 17 run return run function derailed:dev/gen/_wall_relay
execute if score #q_step dr_var matches 18 run return run function derailed:dev/gen/_fresh
execute if score #q_step dr_var matches 1 run return run function derailed:dev/gen/_step_start
execute if score #q_step dr_var matches 2 run return run function derailed:dev/gen/_step_grow
execute if score #q_step dr_var matches 3 run return run function derailed:dev/gen/_step_wall
execute if score #q_step dr_var matches 4 run return run function derailed:dev/gen/_step_rivers
execute if score #q_step dr_var matches 5 run return run function derailed:dev/gen/_step_strays
execute if score #q_step dr_var matches 20 run return run function derailed:dev/gen/_step_finish
return 1
