
# Leaves '#oL' at $(p) where the wood in hand falls short of the $(k) bridges to
#  level $(k) and the track below it, '#gen_order_pct' percent over and rounded
#  up

scoreboard players operation #oneed dr_var = #oR dr_var
$scoreboard players add #oneed dr_var $(k)
scoreboard players operation #oneed dr_var *= #gen_order_pct dr_var
scoreboard players add #oneed dr_var 99
scoreboard players operation #oneed dr_var /= $Hundred dr_const
$execute if score #oW dr_var < #oneed dr_var run scoreboard players set #oL dr_var $(p)
