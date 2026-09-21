
# Takes this tile for the spreading region, due 7 waves on
# A diagonal step costs 7 against a straight step's 5, which is near enough to
#  the real 1.41 to grow round blobs rather than diamonds
# Run as the marker spreading it, positioned on the tile, with $(w) the wave tag
#  the tile is due on

function derailed:dev/gen/_set_id

# Air to the east means this is the last column, since growth is bounded by the
#  black fill and nothing is built past it yet, and the section after wants to
#  know when each tile there was taken
execute if block ~1 ~ ~ air summon marker run function derailed:dev/gen/_edge_mark

$execute summon marker run function derailed:dev/gen/_born_$(w)
scoreboard players add #gen_pending dr_var 1
