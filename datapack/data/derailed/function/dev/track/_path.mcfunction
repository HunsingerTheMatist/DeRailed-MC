# Makes the tile 'new' the whole of team $(team)'s path, run at height $(y), in
#  thousandths of a block, and the end's block, tagged 'dr_end_on', the only
#  rail in the team's rails

$data modify storage derailed:train t$(team).path set value []
$data modify storage derailed:train t$(team).path append from storage derailed:train new
$data modify storage derailed:train t$(team).y set value $(y)
$data modify storage derailed:track t$(team).rails set value []
$data modify storage derailed:track t$(team).rails append from entity @n[type=marker,tag=dr_end_on,distance=0..] Pos
