# Puts the new tile, 'new', on the end of team $(team)'s path, the tile before
#  it leaving toward it by '#d' and turning a corner where '#curve' says, and
#  the end's new block on the end of the team's rails; takes the place the
#  tile before it has in the path into '#last'

$execute store result score #last dr_temp run data get storage derailed:train t$(team).path
scoreboard players remove #last dr_temp 1
$execute store result storage derailed:train t$(team).path[-1].dout int 1 run scoreboard players get #d dr_temp
$execute if score #curve dr_temp matches 1 run data modify storage derailed:train t$(team).path[-1].len set value 2356
$data modify storage derailed:train t$(team).path append from storage derailed:train new
$data modify storage derailed:track t$(team).rails append from entity @n[type=marker,tag=dr_end_on,distance=0..] Pos
