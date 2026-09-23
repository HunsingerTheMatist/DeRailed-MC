# DeRailed Terrain: The Decisions

Written 2026-09-22. This is the companion to `terrain_generation.md`, which says
how each piece is built. This one says what a section is meant to be, what was
decided along the way, and why. Where a number is still provisional it says so.

## What a section is

The map is a row of **sections**, each 32 tiles east to west and 16 north to
south, built one after another going east. The train comes in on a row of the
west edge, where the section before let it out, and leaves by a row of the east
edge that the section chose. Nothing about a section is finished by the section
after it: once built, it is never written to again.

Terrain is made of **regions**, not tiles. Eighteen seeds are scattered, each
grows a blob, and every blob is one kind throughout: ground, wood, iron, water or
rock. Big forests and rock fields are two or three blobs that happen to touch.
The density is one seed to about 28 tiles, so regions are the size they were
at every earlier section size, and a section always looks like a section.

A region holds together edge to edge. Growth never leaves a tile hanging off a
corner of its region, and a tile a river cuts off from its region is handed to
the region beside it, so a lone tile of one kind never sits inside another.

Regions cross the seam. Whatever blob was cut off by the eastern edge of one
section carries on into the next, so a forest is not sliced flat at every 32
tiles. A carried region keeps its kind, and the section it enters draws that much
less of that kind for itself.

## No corridor, and a wall

Nothing is reserved for the track. The section picks the row it will leave by,
leaning toward the top and bottom edges so that the track wanders up and down
the map over a run rather than holding a line, and the terrain is drawn without
regard to it. Where the track can go is settled afterwards: rock is not
impassable but very dear, a thousand a tile, so the cheapest way across only
ever goes through rock where no way round it exists, and where it does, that
rock is **cut out**, leaving a passage one tile wide. Water at both ends of a
cut, river or lake either, runs through the whole of it as river; a river at
one end gives way to the land at the other, ground, wood or iron. Any other
cut is filled in from both ends at once, each tile becoming whatever terrain
other than rock or river is nearest, so the passage takes the terrain it opens
onto at each end. Rock cut to open a pinch up never becomes river. The exit
tile
is kept off rock where any row of the east edge is clear of it, so a section
never has to dig in at its very edge for want of a better row.

On hard that is made to happen. Once the regions have grown, a **wall** of rock
is run from the north border to the south, seed to seed, one region thick and
meandering wherever the seeds lead it, with every region on the way from one
seed to the next taken into it, so that it has no gap and reaches both borders.
Every hard section's route has to cut through it somewhere, and the cut, one
tile wide with rock either side, is the pinch hard asks for.

## Rivers

Rivers run **north to south**, on the boundaries between regions, so every
route across has to cross one. They never come in from or leave by a seam, so
each section's rivers are its own and the seam rule holds.

Every section gets a first river of at least 20 corners. If that river came to
fewer than 40, it gets a second one as well, starting from the same border at
least six columns away and held to whatever brings the pair to 40 between them,
never less than 10, and allowed to end by running into the first. A river that
can find no way out from five different starts lays the longest line it found
and ends in a lake, so a river never just stops on dry ground.

Two crossings a section, or one long one, is the amount of bridging the section
is meant to ask for.

## Difficulty

Difficulty is three **tiers**, easy, medium and hard, chosen before a section is
built. A tier decides two things: what the regions are drawn as, and what a
section has to cost.

### What a route costs

The measure of a section is **what the cheapest way across costs a rail**. Each
tile costs something to lay track through - ground 1, wood or iron 2, water 4,
rock 1000 - and the cheapest route from entry to exit is found over the finished
terrain, then measured again over what it cut if it had to cut through rock. Its cost is divided by its length in rails, because the time the players
get is the rails they lay: a zig-zag route is not harder, it just takes longer
and buys the time to match. On top of that, every rail past the 32 of a straight
crossing adds one percent, since a longer section is more rails out of the same
supply.

A section is accepted when that figure lies inside the tier's band. Hard's band
of 2.65 to 3.30 comes from measured sections. **Easy's and medium's are
placeholders** until a batch run on each has shown where they land. A section
outside its band redraws its kinds and tries again, up to five times, and then
ships as it is and is counted.

### How pinched the train is

Cost per rail says how much work the route is. It says nothing about the
players getting round the train, which is a solid body two long and one wide
that nobody can pass through. So the route is also scored for **pinching**:
slide that box along the track and note where rock closes both its sides at
once. A run of pinched positions costs its length cubed, so one long squeeze
counts far more than the same length in pieces, and the section's pinch score
is the sum over its runs. Only rock counts as a wall, since the players can
clear anything else, and the map's edges count as rock too: nobody gets round
the train past the north or south edge, and what lies past the east edge is not
built yet.

Each tier has a ceiling for that score, and hard has a floor: easy allows none,
medium two single rows of rock either side far enough apart not to touch, hard
anything from one such row up to a corridor five long. A section over its ceiling is not
rejected: the rock beside its worst run is cut back until it passes, the same
cutting the route uses to get through rock at all. A hard section under its
floor rerolls its kinds like a cheap one.

This replaces the idea of a pinch as a property of a tile, which asks whether
a tile is the only local link between two open areas. That is a question about
the map; ours is a question about the route, which is the only place the train
ever is.

### What regions are drawn as

Each tier has a table of weights:

| tier | ground | rock | wood | iron | water |
|---|---|---|---|---|---|
| easy | 45 | 15 | 15 | 15 | 10 |
| medium | 35 | 21 | 18 | 18 | 9 |
| hard | 0 | 43 | 14 | 14 | 29 |

Easy is mostly open ground. Medium is the base mix. Hard has no ground at all,
so every tile of a route costs at least 2, most of the rest is rock and water,
and the wall runs through it.

### Why the draw is not a plain roll

Rolling each seed on its own from those tables gave sections that ran away: a
hard section came out with ten iron regions of eighteen, with every carried row
iron as well. That is a one-in-ninety draw, and there are a lot of sections.

So each section draws from a **bag**. The tier's weights go in, ten thousand
between them, and every draw takes half a seed's share off the kind drawn and
hands the same amount out to the other kinds in the tier's own ratios. A kind
drawn often gets less likely; a kind drawn too often goes into debt and sits out
until the others' draws have paid it back, which for a rare kind is most of the
bag and for a common one a few picks. Half a share was chosen over a whole one
on purpose: a whole share pins every count to its target and the randomness is
gone, half lets sections lean one way while keeping any kind from running off.
Modelled over 200,000 hard sections, seven or more iron went from one section
in 22 to one in 67, and eight or more from one in 91 to one in 1000, while six
still came up one section in eleven.

Underneath the bag sit **floors**: at least 3 wood, 3 iron and 2 water in every
section, and 3 rock, or 4 on hard. They are met by holding back the last seeds
drawn for whatever is still owed, never by changing a seed after the fact, and
with the bag in place they rarely have to act.

## Placeholders and open questions

- The easy and medium cost bands are guesses until measured
- Nothing has been profiled since the sections were 35 by 20 with one river and
  a depth-first flood. The least-cost flood and the bag both cost more than what
  they replaced, and how much is not known
- The bag and the floors have been modelled, not yet watched over many sections
  in the game
- There is no hard cap on how many regions of a kind a section can hold, only
  the bag's thin tail. A cap would be a few lines if the tail ever shows
- The wall cannot take in a region carried over the seam, which keeps its kind,
  so a wall laid through one has a hole; it is laid again from another column,
  up to four times, and the report counts any hole left
- Sections are placeholder blocks in a test area, built in one go. Real blocks,
  a queue spread over ticks, and stations are all still to come
