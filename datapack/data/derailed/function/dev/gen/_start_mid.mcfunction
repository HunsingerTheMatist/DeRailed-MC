
# Marks the tile on column $(x) and row $(z) with a marker tagged
#  'dr_start_mid', and with a small stand one over it where the marks are on
# Positioned at the section's corner, which stands at z 0

$summon marker ~$(x) ~ ~$(z).5 {Tags:["dr_start_mid"]}
$execute if score #gen_marks dr_var matches 1 run summon armor_stand ~$(x) ~16 ~$(z).5 {NoGravity:1b,Invulnerable:1b,Small:1b,Tags:["dr_seed_mark"]}
