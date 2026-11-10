
# Takes this tile for the carried region straight away

function derailed:dev/gen/_set_id
execute summon marker run function derailed:dev/gen/_born_0
scoreboard players add #gen_pending dr_var 1

# A carried region has no seed to stand over, and its whole line of tiles along
#  this column is what the rest of the section grows against, so the line gets
#  marked too - small, to tell it from a seed - though in the first section,
#  where the start station's ground and the void are all that come in this
#  way, they are marked at the points they grow from instead
execute if score #gen_marks dr_var matches 1 unless score #gen_section dr_var matches 0 run summon armor_stand ~ ~16 ~ {NoGravity:1b,Invulnerable:1b,Small:1b,Tags:["dr_seed_mark"]}
