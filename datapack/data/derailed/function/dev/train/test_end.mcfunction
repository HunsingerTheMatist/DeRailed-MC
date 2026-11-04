# Lays team $(team)'s test track and train as 'dev/train/test' does, but with
#  no more rounds of the loop to come, so the train runs round it once to the
#  end of its 14 tiles and derails, about 90 seconds at the default speed
# Run by a player standing where the track's northwestern corner goes

$function derailed:dev/train/test {team:$(team)}
$data remove storage derailed:train t$(team).loop
