
# Adds level $(p)'s wood, iron and track to what is in hand and what is owed

$execute if score #ow$(p) dr_ord matches -2147483648.. run scoreboard players operation #oW dr_var += #ow$(p) dr_ord
$execute if score #oi$(p) dr_ord matches -2147483648.. run scoreboard players operation #oI dr_var += #oi$(p) dr_ord
$execute if score #or$(p) dr_ord matches -2147483648.. run scoreboard players operation #oR dr_var += #or$(p) dr_ord
