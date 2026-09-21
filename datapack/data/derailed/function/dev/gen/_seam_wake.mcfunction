
# Takes this tile for the carried region now its wave has come round
# Run as the waiting marker, with $(w) the wave tag of the wave being run

# Another region reaching here first has the better claim, and the wait is over
#  either way
scoreboard players remove #gen_waiting dr_var 1
scoreboard players add #seam_lost dr_var 1
execute unless block ~ ~ ~ black_concrete run return run kill @s
scoreboard players remove #seam_lost dr_var 1

scoreboard players operation #gen_id dr_var = @s dr_id
function derailed:dev/gen/_set_id
execute if score #gen_marks dr_var matches 1 run summon armor_stand ~ ~16 ~ {NoGravity:1b,Invulnerable:1b,Small:1b,Tags:["dr_seed_mark"]}

# Tagged for the wave being run right now, since the waking happens before this
#  wave hands anything out and the tile should spread from here on
$execute summon marker run function derailed:dev/gen/_born_$(w)
scoreboard players add #gen_pending dr_var 1
kill @s
