# Lays a test track and train for each team as 'dev/train/test' does, red's
#  where the player stands and blue's 12 blocks south of it, 3 blocks clear of
#  red's
# Run by a player standing where red's track's northwestern corner goes

function derailed:dev/train/test {team:1}
execute positioned ~ ~ ~12 run function derailed:dev/train/test {team:2}
