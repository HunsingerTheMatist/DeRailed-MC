# The Pile Search

Written 2026-10-15. How items find somewhere to go when they are not put down
exactly where a player clicked: dropping them, and moving piles off a tile a
rail is laid on.

## The order

`item/place_near` tries every block within 20 steps of where it starts,
counting steps along x, y and z, so the blocks it reaches make a diamond. They
are tried cheapest first, a step across costing 1 and a step up or down costing
2, as a breadth-first search through open space would reach them. At the same
cost, the block with fewer steps up or down goes first, then one below before
one above, then round from north through east, south and west. The start
itself is tried first.

It is a plain order by distance, not a flood: it reaches through walls and
mountains alike.

The order is written out ahead of time by `utils/generate_search.py`, one line a
block. Change the reach or the costs there and run it again; never edit the
functions by hand. Macros would avoid the long files, but every offset would
compile another copy of the macro.

## One list for each starting height

The map is 15 blocks high, so a start at a given height above the map's lowest
can only ever reach blocks from that far below it to 15 less that far above it.
`item/_spots/h0` to `h15` each hold only those blocks for a start 0 to 15 above
the lowest, about 6,100 to 8,900 lines each instead of the 11,500 in the whole
diamond, and their lines never need to check height. `item/_try_spots` picks
the list from `#sy0`, the map's lowest less the start's height; a start below
the map's heights takes `h0` and one above them `h15`, which will hardly ever
happen. The generator's `SPAN` has to match `$MapMaxY` less `$MapMinY`.

Benched 2026-10-15, ten searches a tick with every spot refused after its block
tests, the lists by height against one guarded list for the whole diamond:

| start | one list | lists by height |
|---|---|---|
| flat ground mid-map, y15 | 450 ms first run, 355 ms second | 288 ms first run, 238 ms second |
| flat ground in a corner | 338 ms | 188 ms |
| a mountain top | 429 ms | 370 ms |
| a slope at y22 to 23 | 495 ms | 396 ms |

About a third faster on the ground, where most drops happen, whichever ran
first; on the mountain and the slope the gap is inside the 15% the second run of
a pair gains from the first warming up. The times include the profiler's own
cost, so only the comparison means much. The lists take about 27 MB between
them. `dev/bench/search` runs the same ten searches.

## The map's limits

Each line first checks its block is inside the map across, as plain score
tests, so a block outside costs no block or entity test. `item/_search_window`
works out how far the map reaches from the start west and east (`#sx0` to
`#sx1`) and north and south (`#sz0` to `#sz1`), and how far its lowest is
(`#sy0`), from the map's limits, in `dr_var`:

| score | what it is |
|---|---|
| `$MapMinX`, `$MapMaxX` | the blocks across the map, west to east |
| `$MapMinZ`, `$MapMaxZ` | the blocks across the map, north to south |
| `$MapMinY` | the lowest block a pile can stand in, over the ground |
| `$MapMaxY` | the highest block a pile can stand in, over the highest rock |

`dev/big/_go` sets them for the map it builds (x 1100 to 1195, z 0 to 47, y 15
to 30), and `load` sets the same as defaults. They are meant to move with the
game's window later, which the search needs nothing more for.

## Each block

`item/_try_spot` tests the cheapest things first:

1. The block must be free to place in, or a bottom slab or stairs; anything
   else, which is most of the diamond below and inside the terrain, fails on
   its first block test.
2. It must stand on a floor: the block under it, or the block itself where that
   is a bottom slab or stairs. Air with nothing under it, most of the diamond
   above the ground, fails here, still on block tests alone.
3. A placement standing in the block takes it: items merge into it where it is
   of the same item, and nothing goes there where it is not. A pile counts only
   in the block it stands in, not those above it that it reaches into. This
   check is skipped altogether where `item/place_near` found no placement
   within reach when it started, saving an entity lookup on every block.
4. Otherwise `item/place_on_floor` makes its usual checks: no track tile, room
   above and nothing in the way.

Each spot takes as many of the items as it can, counted off `#search_left`, and
the search goes on with the rest; it stops once none are left. Whatever finds
nowhere stays with whoever dropped it.

## Cost

Usually a spot turns up within the first few dozen blocks. Where nothing near
is free, one search runs every line, tens of thousands of commands, more than
the default 65536 a function chain may run, so `load` raises
`max_command_sequence_length` (26.3's name for the old `maxCommandChainLength`)
to 1000000.
