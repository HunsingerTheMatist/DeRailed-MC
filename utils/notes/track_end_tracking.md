# Tracking the End of the Track

Written 2026-09-18. This is an agreed design, not yet implemented.

## The mechanic

Rails go down one at a time and only at the end of the track. The rail just
placed can be taken back again. Rails the train has already passed cannot.

So the only edits ever made are at the very end: push one, pop one. That is a
stack, and the implementation should be a stack rather than something that tries
to rediscover the order later.

## Why not work it out from the rails themselves

Reading the track's shape to find "which neighbour is my predecessor" looks
possible and is not. A later stretch of track can run alongside an earlier one
without ever closing a loop - right three, down one, left three puts the end rail
directly beside the start rail - so an end rail can have two neighbouring rails
with nothing in the block states to say which came first. Guarding with "the
track may not form a loop" does not cover it, since no loop was formed.

Per-rail markers would work, but they cost an entity per rail, need index
bookkeeping to stay ordered, and depend on the chunk staying loaded. A list in
storage keeps the order inherently, costs nothing per rail and persists.

## The data

Storage `derailed:track`, path `rails`: a list of positions, each one in `Pos`
format - three doubles at the block centre - so entries copy straight in and out
of an entity's `Pos` with no macro and no conversion.

- `rails[-1]` is the current end of the track
- `rails[0]` is the floor: the oldest rail that may still not be taken
- the list holds only the rails that are still removable

## The two entities

- a **marker** tagged `dr_track_end` - the placement anchor. It always sits on
  the end of the track, and placement is allowed on tiles within 1 of it
- an **interaction** tagged `dr_track_take` - the click target for taking the
  last rail back

They are split because the two affordances come and go separately: there is
always somewhere to place, but not always something to take. The interaction is
**parked below the map** rather than killed when nothing may be taken, which
keeps it out of both the click and the `distance=` tests.

Park it shallow. Entities are discarded once their Y drops below the dimension's
`min_y` minus 64, and `derailed:game` has `min_y` 0, so anything below **-64 is
deleted**. Around -20 is safely out of reach and safely above the line.

## The operations

Placing, after moving the anchor onto the new rail:

```mcfunction
data modify storage derailed:track rails append from entity @n[type=marker,tag=dr_track_end,distance=0..] Pos
```

Taking the last rail back:

```mcfunction
# nothing to take once the list is down to its floor entry
execute unless data storage derailed:track rails[1] run return fail

data modify entity @n[type=marker,tag=dr_track_end,distance=0..] Pos set from storage derailed:track rails[-2]
data remove storage derailed:track rails[-1]
```

Then move the interaction onto the new end, or park it if the list is now down to
its floor. A single rule is easier to keep right than scattered spawn and hide
logic: after **any** change to the list, the interaction belongs on the end if
`rails[1]` exists and below the map otherwise.

## What the command set gives us

All checked against 26.3 rather than assumed:

- **Negative indices work.** The path resolves `index < 0` as `size + index` and
  then bounds-checks it, so `[-1]` and `[-2]` are the last two entries. An index
  outside the list is simply **no match**: the command fails and changes nothing,
  which is what makes `execute unless data storage derailed:track rails[1]` a
  free "nothing to take" guard
- **`data remove ... rails[-1]`** pops the end
- **`data get` on a list returns its size**, so
  `execute store result score #track_left dr_var run data get storage derailed:track rails`
  is a free count of rails remaining - useful for warning that the train is about
  to run out
- **`data modify entity ... Pos set from storage ...`** moves an entity with no
  macro, but it does not always refresh the entity's tracked chunk section in the
  same tick, so a `distance=` selector can disagree for one tick. Taking a rail
  and placing the next one will not happen in the same tick, so this should not
  bite - but it is the first thing to suspect if something is off by exactly one
  tick

## Still to decide

- **Whether the train pops `rails[0]` as it advances.** If it does, the rule
  becomes "`rails[0]` is where the train is", everything behind the train is
  already gone from the list, and **no station reset is needed** - rails from
  before the last station are unremovable for the same reason as any other rail
  the train has passed. If it does not, the list needs clearing at each station,
  reseeded with the anchor's position as the new floor
- **Whether taking should also be refused when the train is next to the end**, so
  a rail cannot be pulled out from under it

## Gotchas

- Writing the list from the entity's `Pos` makes storage downstream of the
  entity, so a mispositioned anchor quietly poisons the history. Writing both
  from the same computed placement position avoids that
- Two players taking in the same tick would both pop. Funnel removals through one
  function
