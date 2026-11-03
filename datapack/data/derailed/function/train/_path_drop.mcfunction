
# Drops the tile at the back of team $(team)'s path, which moves every axle of
#  the team's tile one nearer the start of it

$data remove storage derailed:train t$(team).path[0]
$scoreboard players remove @e[type=marker,tag=dr_axle,scores={dr_team=$(team)},distance=0..] dr_ai 1
