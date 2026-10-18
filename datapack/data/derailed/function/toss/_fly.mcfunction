# Moves this thrown pile a tick as a dropped item moves: falls '$TossGravity'
#  faster, flies its velocity through Bookshelf's 'bs.move', which stops it
#  against blocks and anything tagged 'dr_hard' and calls 'toss/_hit', then
#  slows by '$TossDrag' hundredths; it merges into piles of the same resource
#  it touches, and comes down where it lands, where it falls into water, or
#  after 10 seconds in the air wherever it is
# Its thrower is passed over until the box has cleared them
# A pile dropped from a placement stays where it is while it waits its turn
# Run as the thrown display, at it

execute if score @s dr_toss_wait matches 1.. run return run scoreboard players remove @s dr_toss_wait 1
scoreboard players add @s dr_toss_age 1
execute if score @s dr_toss_age matches 200.. run return run function derailed:toss/_land
scoreboard players operation @s bs.vel.y -= $TossGravity dr_const

# The thrower is tagged for 'bs.move' to pass over, just for this move, while
#  they still stand in the box, as far as a block across and two high
scoreboard players operation #thrower dr_temp = @s dr_player_id
execute if entity @s[tag=!dr_toss_clear] as @a[distance=..8] if score @s dr_player_id = #thrower dr_temp run tag @s add dr_toss_thrower
execute if entity @s[tag=!dr_toss_clear] positioned ~-0.5 ~ ~-0.5 unless entity @a[tag=dr_toss_thrower,dx=0,dy=1,dz=0] run tag @s add dr_toss_clear
execute if entity @s[tag=!dr_toss_clear] run tag @a[tag=dr_toss_thrower] add bs.move.omit
function #bs.move:apply_vel {scale:0.0001,with:{entities:"dr_hard",on_collision:"function derailed:toss/_hit"}}
tag @a[tag=dr_toss_thrower] remove bs.move.omit
tag @a[tag=dr_toss_thrower] remove dr_toss_thrower

# Piles of the same resource it touches take what they can, and the rest flies
#  on
execute at @s if function derailed:toss/_merge run return 0

execute if entity @s[tag=dr_toss_landed] at @s run return run function derailed:toss/_land
execute at @s if block ~ ~ ~ water run return run function derailed:toss/_land

# One that started a move inside a block passes through every block after it,
#  since Bookshelf leaves it tagged to pass through, so one that falls under
#  the map's lowest height lands from that height straight up from it instead
execute store result score #toss_y dr_temp run data get entity @s Pos[1]
execute if score #toss_y dr_temp < $MapMinY dr_var store result storage derailed:toss surface.y int 1 run scoreboard players get $MapMinY dr_var
execute if score #toss_y dr_temp < $MapMinY dr_var run return run function derailed:toss/_resurface with storage derailed:toss surface

scoreboard players operation @s bs.vel.x *= $TossDrag dr_const
scoreboard players operation @s bs.vel.x /= $Hundred dr_const
scoreboard players operation @s bs.vel.y *= $TossDrag dr_const
scoreboard players operation @s bs.vel.y /= $Hundred dr_const
scoreboard players operation @s bs.vel.z *= $TossDrag dr_const
scoreboard players operation @s bs.vel.z /= $Hundred dr_const
