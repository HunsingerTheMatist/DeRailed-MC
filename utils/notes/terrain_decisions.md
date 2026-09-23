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

Regions cross the seam. Whatever blob was cut off by the eastern edge of one
section carries on into the next, so a forest is not sliced flat at every 32
tiles. A carried region keeps its kind, and the section it enters draws that much
less of that kind for itself.

## The corridor

Before anything grows, the section picks a **chain** of seeds from the entry row
to the exit row: forward across the section, then along the far side to the seed
nearest the exit. Those regions are the corridor the track will want, and they
are never rock. Everything else about them - what they are drawn as, how wide
the corridor comes out - falls out of the growth and the draw.

The exit row leans toward the top and bottom edges rather than the middle, so
that the track wanders up and down the map over a run rather than holding a
line.

## Rivers

Rivers run **north to south**, on the boundaries between regions, so every
route across has to cross one. They never come in from or leave by a seam, so
each section's rivers are its own and the seam rule holds.

Every section gets a first river of at least 25 corners. If that river came to
fewer than 50, it gets a second one as well, starting from the same border at
least ten columns away and held to whatever brings the pair to 50 between them,
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
rock never - and the cheapest route from entry to exit is found over the finished
terrain. Its cost is divided by its length in rails, because the time the players
get is the rails they lay: a zig-zag route is not harder, it just takes longer
and buys the time to match. On top of that, every rail past the 32 of a straight
crossing adds one percent, since a longer section is more rails out of the same
supply.

A section is accepted when that figure lies inside the tier's band. Hard's band
of 2.65 to 3.30 comes from measured sections. **Easy's and medium's are
placeholders** until a batch run on each has shown where they land. A section
outside its band redraws its kinds and tries again, up to five times, and then
ships as it is and is counted.

### What regions are drawn as

Each tier has two tables of weights, one for the corridor and one for the rest:

| tier | on the chain | off the chain |
|---|---|---|
| easy | ground 60, wood 16, iron 16, water 8 | ground 24, rock 24, wood 20, iron 20, water 10 |
| medium | ground 20, wood 32, iron 32, water 16 | ground 35, rock 21, wood 18, iron 18, water 9 |
| hard | wood 40, iron 40, water 20 | rock 43, water 29, wood 14, iron 14 |

Easy is a corridor of open ground with the supply piled up beside it. Medium
is the base mix, with the corridor packed a little denser than the sides. Hard
has no ground at all, so every tile of a route costs at least 2, and the sides
are mostly rock and water.

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
- Sections are placeholder blocks in a test area, built in one go. Real blocks,
  a queue spread over ticks, and stations are all still to come
