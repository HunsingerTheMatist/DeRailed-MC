
# Builds the map from the first seed left in 'prof.left', moved on by
#  '#prof_base', then the next, until none are left

execute store result score #prof_seed dr_var run data get storage derailed:gen prof.left[0]
scoreboard players operation #prof_seed dr_var += #prof_base dr_var
execute store result storage derailed:gen prof.seed int 1 run scoreboard players get #prof_seed dr_var
function derailed:dev/gen/_reseed with storage derailed:gen prof
data remove storage derailed:gen prof.left[0]
function derailed:dev/gen/test
execute if data storage derailed:gen prof.left[0] run function derailed:dev/gen/_profile_map
