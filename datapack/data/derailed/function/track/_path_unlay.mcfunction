# Takes the last tile off team $(team)'s path and the last block off its rails,
#  and copies the tile before it, now the last, into 'tile'

$data remove storage derailed:train t$(team).path[-1]
$data remove storage derailed:track t$(team).rails[-1]
$data modify storage derailed:train tile set from storage derailed:train t$(team).path[-1]
