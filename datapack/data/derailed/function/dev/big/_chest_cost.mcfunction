
# Works out how many changes make the block beside this one, $(x) $(z) away on
#  side $(s), a full block, into '#ch_f$(s)', a slab, into '#ch_s$(s)', air,
#  into '#ch_a$(s)', a slab or air, into '#ch_o$(s)', and a slab or a full
#  block, into '#ch_r$(s)', 9 where none will:
#  a rock slab becomes a full block or air, bedrock with air over it becomes a
#  slab and then air, and air over bedrock becomes a slab and then a full block
# Positioned at the chest's top block

$scoreboard players set #ch_f$(s) dr_temp 9
$scoreboard players set #ch_s$(s) dr_temp 9
$scoreboard players set #ch_a$(s) dr_temp 9
$execute if block ~$(x) ~ ~$(z) bedrock run scoreboard players set #ch_f$(s) dr_temp 0
$execute if block ~$(x) ~ ~$(z) bedrock if block ~$(x) ~1 ~$(z) air run scoreboard players set #ch_s$(s) dr_temp 1
$execute if block ~$(x) ~ ~$(z) bedrock if block ~$(x) ~1 ~$(z) air run scoreboard players set #ch_a$(s) dr_temp 2
$execute if block ~$(x) ~ ~$(z) cobbled_deepslate_slab run scoreboard players set #ch_f$(s) dr_temp 1
$execute if block ~$(x) ~ ~$(z) cobbled_deepslate_slab run scoreboard players set #ch_s$(s) dr_temp 0
$execute if block ~$(x) ~ ~$(z) cobbled_deepslate_slab run scoreboard players set #ch_a$(s) dr_temp 1
$execute if block ~$(x) ~ ~$(z) air if block ~$(x) ~-1 ~$(z) bedrock run scoreboard players set #ch_f$(s) dr_temp 2
$execute if block ~$(x) ~ ~$(z) air if block ~$(x) ~-1 ~$(z) bedrock run scoreboard players set #ch_s$(s) dr_temp 1
$execute if block ~$(x) ~ ~$(z) air run scoreboard players set #ch_a$(s) dr_temp 0
$scoreboard players operation #ch_o$(s) dr_temp = #ch_s$(s) dr_temp
$scoreboard players operation #ch_o$(s) dr_temp < #ch_a$(s) dr_temp
$scoreboard players operation #ch_r$(s) dr_temp = #ch_s$(s) dr_temp
$scoreboard players operation #ch_r$(s) dr_temp < #ch_f$(s) dr_temp
