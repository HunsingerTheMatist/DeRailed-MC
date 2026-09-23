
# Starts the band at the seed nearest column $(x) of the north border, running
#  it there from that point on the border
# Positioned at the section's corner

$scoreboard players set #wall_lx dr_var $(x)
scoreboard players operation #wall_lx dr_var += #gen_cx dr_var
scoreboard players operation #wall_lz dr_var = #gen_cz dr_var
$execute positioned ~$(x) ~ ~ as @n[type=marker,tag=dr_seed,distance=..40] run function derailed:dev/gen/_wall_join
