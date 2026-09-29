
# Takes this region for the lake against an even chance of the ones already seen
# The first one in is taken outright and the $(n)th after it takes over one time
#  in n, which leaves every one of them as likely as the last without having to
#  hold the whole list first
# Taking the first outright is not only shorter than rolling one time in one: a
#  range with nothing to choose between is not worth asking the game for

execute if score #lake_n dr_var matches 1 run return run scoreboard players operation #lake_id dr_var = #gen_id dr_var

$execute store result score #lake_r dr_var run random value 1..$(n) derailed:gen
execute if score #lake_r dr_var matches 1 run scoreboard players operation #lake_id dr_var = #gen_id dr_var
