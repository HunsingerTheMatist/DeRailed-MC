
# Marks row $(z) of the column $(k) tiles west of the first with a marker tagged
#  'dr_void_mid', and with a small stand one over it where the marks are on
# Positioned at the section's corner, which stands at z 0

$summon marker ~-$(k) ~ ~$(z) {Tags:["dr_void_mid"]}
$execute if score #gen_marks dr_var matches 1 run summon armor_stand ~-$(k) ~16 ~$(z).5 {NoGravity:1b,Invulnerable:1b,Small:1b,Tags:["dr_seed_mark"]}
