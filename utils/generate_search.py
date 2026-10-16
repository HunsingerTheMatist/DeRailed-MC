"""Writes the order the pile search tries the blocks round its start in:
'item/_spots/h0' to 'h<SPAN>', one list for each height a start can have above
the map's lowest, and 'item/_try_spots', which picks the list for the start.

Every block within REACH steps of the start, counting steps along x, y and z,
is tried, cheapest first: a step across costs 1 and a step up or down costs 2.
At the same cost the block with fewer steps up or down goes first, then one
below before one above, then round from north through east, south and west.

A list holds only the blocks inside the map's heights for a start that many
blocks above the map's lowest, taking the map to be SPAN blocks high,
'$MapMaxY' less '$MapMinY'. Each of its lines first checks the block lies
inside the map across, against how far the map reaches from the start west and
east, '#sx0' to '#sx1', and north and south, '#sz0' to '#sz1', which
'item/_search_window' works out; those comparisons are on scores alone, so a
block outside the map costs no block or entity test.

Run from the repository root: py -3 utils/generate_search.py
"""

import math
import os

REACH = 20
ACROSS_COST = 1
UP_DOWN_COST = 2
SPAN = 15
FUNCTIONS = os.path.join('datapack', 'data', 'derailed', 'function', 'item')

HEADER_HEIGHT = """\
# Tries the blocks within {reach} steps of here, cheapest first, putting items in
#  each until none are left, for a start {k} blocks above the map's lowest: only
#  the blocks from {k} below to {up} above, the map's heights, each checked to lie
#  inside the map across
# A step across costs {across} and a step up or down {up_down}, and at the same cost
#  fewer steps up or down go first, then below before above, then round from
#  north
# Written by 'utils/generate_search.py'; edit that and run it again rather than
#  this
# Run at the bottom middle of the block the search starts from
#
# Returns 1 once all the items are down, fail otherwise
"""

HEADER_PICK = """\
# Tries the blocks within {reach} steps of here, cheapest first, from the list
#  for how far the start stands above the map's lowest, which '#sy0' holds as a
#  negative: a start below the map's heights takes the lowest's list and one
#  above them the highest's, the map taken to be {span} blocks high
# Written by 'utils/generate_search.py'; edit that and run it again rather than
#  this
# Run at the bottom middle of the block the search starts from
#
# Returns 1 once all the items are down, fail otherwise
"""


def order_key(offset):
    dx, dy, dz = offset
    cost = (abs(dx) + abs(dz)) * ACROSS_COST + abs(dy) * UP_DOWN_COST
    # A facing round from north, clockwise seen from above, in [0, 2 pi)
    facing = math.atan2(dx, -dz) % (2 * math.pi)
    return (cost, abs(dy), 0 if dy <= 0 else 1, round(facing, 9))


def line(dx, dy, dz):
    guards = (
        f'if score #sx0 dr_temp matches ..{dx} if score #sx1 dr_temp matches {dx}.. '
        f'if score #sz0 dr_temp matches ..{dz} if score #sz1 dr_temp matches {dz}.. '
    )
    return f'execute {guards}positioned ~{dx} ~{dy} ~{dz} if function derailed:item/_try_spot run return 1'


def write(path, lines):
    text = '\n'.join(lines) + '\n'
    with open(path, 'wb') as f:
        f.write(text.replace('\n', '\r\n').encode('utf-8'))
    print(f'{path}: {len(lines)} lines, {os.path.getsize(path)} bytes')


def main():
    offsets = [
        (dx, dy, dz)
        for dx in range(-REACH, REACH + 1)
        for dy in range(-REACH, REACH + 1)
        for dz in range(-REACH, REACH + 1)
        if abs(dx) + abs(dy) + abs(dz) <= REACH
    ]
    offsets.sort(key=order_key)

    os.makedirs(os.path.join(FUNCTIONS, '_spots'), exist_ok=True)
    for k in range(SPAN + 1):
        kept = [o for o in offsets if -k <= o[1] <= SPAN - k]
        write(os.path.join(FUNCTIONS, '_spots', f'h{k}.mcfunction'),
              [HEADER_HEIGHT.format(reach=REACH, k=k, up=SPAN - k, across=ACROSS_COST, up_down=UP_DOWN_COST)]
              + [line(*o) for o in kept] + ['return fail'])

    pick = [HEADER_PICK.format(reach=REACH, span=SPAN)]
    pick.append('execute if score #sy0 dr_temp matches 0.. run return run function derailed:item/_spots/h0')
    pick += [
        f'execute if score #sy0 dr_temp matches {-k} run return run function derailed:item/_spots/h{k}'
        for k in range(1, SPAN)
    ]
    pick.append(f'return run function derailed:item/_spots/h{SPAN}')
    write(os.path.join(FUNCTIONS, '_try_spots.mcfunction'), pick)


if __name__ == '__main__':
    main()
