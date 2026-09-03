# Throwing Resources — Design Exploration

> **Status:** Parked, not implemented. This records a design discussion so it
> does not have to be re-derived later. The decisions below were reached in
> conversation but none are binding, and the mechanic is blocked on an unsolved
> problem (see [Open problems](#open-problems)).

## The idea

Instead of Q placing a resource on the tile under the player, it launches the
resource along the player's facing in a visible arc. It lands some distance away
and becomes a normal pile. Throw distance scales inversely with how much is
thrown, so a single item goes furthest.

The appeal is that it gives co-op play a delivery verb. In *Unrailed!* getting
material to a teammate across a gap is a core interaction, and right now DeRailed
has no way to move a resource except to walk it there.

## Decisions reached

### Distance scales with the amount thrown, not the amount held

Rough targets:

| thrown | distance |
|--------|----------|
| 1      | 5.0      |
| 2      | 3.0      |
| 3      | 1.5      |

The original framing scaled distance by the stack *held*, which meant the same
keypress got stronger as the hand emptied — hold 3 and each successive throw
goes 1.5, then 3, then 5 blocks. Coherent as an encumbrance rule, but it makes
throwing useless for delivery, since the first throw of a full hand is the worst
one.

Keying off the amount thrown turns the two existing keybinds into two distinct
verbs: **Q is a precise long toss of one, Ctrl+Q is a short heavy dump of the
stack.** This costs nothing to implement, because
`item/event/item_dropped.mcfunction` already derives exactly that value from
`Item.count` clamped against the carried record, in `#curr_resource_count`.

Distances should live in `dr_config` in tenths (`$ThrowDist1 50`, `$ThrowDist2
30`, `$ThrowDist3 15`) so they can be retuned with a `/scoreboard` command
during playtesting rather than a rebuild. With `$HandCap` at 3 a three-entry
lookup beats any formula.

### Simulate the flight; do not precompute the destination

The alternative was to solve for a launch velocity that lands exactly on a tile
centre. Rejected for three reasons:

1. It is strictly more work — it needs a raycast to find the target tile *and
   then* an inverse solve on the parabola, where simulating is just "integrate
   one step per tick, check the block, stop when blocked".
2. Terrain is mutable mid-flight. Mining is the core loop, so a second player
   clearing a block during the ~1s flight is not a rare case, and a precomputed
   arc would be resolving against stale data.
3. It composes badly with mid-air catching, where the destination is discarded
   anyway.

**Tile alignment is solved without precomputing.** As soon as the descending
step is blocked, the landing tile is known, so the *final hop of the arc is the
correction*: teleport the display to the tile centre with `teleport_duration`
set and let the client interpolate. Worst case that bends the last ~0.7 blocks
of a 5-block flight across a tick or two, which reads as the item settling
rather than as a snap.

A useful side effect: since each step is checked, the **last air cell before the
obstruction** is always known. That is a better failure mode than the current
`place_fail` path — a resource that drops at the foot of the wall it hit
explains itself, where one that teleports back into the hand a second later does
not.

### Launch from hand height, with apex scaled to range

Launch from roughly 1.3–1.4 above the player's Y rather than from the feet. The
play area is only 1–2 blocks of relief, so starting above most of it means there
is usually nothing to clip and the "flies up, hits nothing, falls" look never
appears.

Hold the launch angle constant rather than the apex height, so at ~45° the apex
is about range/4 above the launch point:

| thrown | range | apex above hand |
|--------|-------|-----------------|
| 1      | 5.0   | ~1.25           |
| 2      | 3.0   | ~0.75           |
| 3      | 1.5   | ~0.4            |

This keeps short heavy dumps as flat little tosses instead of lobbing three logs
six blocks into the air to travel a block and a half, while long throws still
visibly arc.

One integration step per tick. At max range that is ~0.4 blocks/tick, comfortably
under 1, so a projectile cannot tunnel through a one-block wall.

### Mid-air catching is additive — build it second

Letting another player snatch a thrown resource out of the air is attractive and
fits the co-op framing.

It is cleanly separable because **the in-flight entity is transient either way.**
Landing has to go through `try_place` → `place_new`/`place_existing`, since the
throw may merge into a pile that already exists, so the flying entity is always
destroyed and replaced on landing. Catchability is therefore an interaction
hitbox riding along with the display, not a change to how flight works. Build the
flight first; if catching feels bad in playtest it is one file to delete.

Three things it needs that a landed pile does not:

- **A larger hitbox than the landed pile** (~1.5 blocks). The target moves ~0.4
  blocks/tick and the clicking player sees it where the server had it 50–100ms
  ago. At normal pile size the catch is a lottery.
- **Take-only routing.** `interaction_used` currently decides take-vs-give from
  hand contents; a flying resource must never accept a give.
- **A brief thrower exclusion**, or the first tick of every throw is a self-catch
  when someone taps Q while looking down.

## How it would attach to existing code

The naive form is a single clause on the end of the existing drop handler, since
`at @s` already carries the player's rotation as well as position:

```mcfunction
execute as @p[...] at @s rotated ~ 0 positioned ^ ^ ^5 align xyz positioned ~0.5 ~ ~0.5 run function derailed:item/try_place
```

`rotated ~ 0` keeps yaw and flattens pitch. Pitch should not affect distance —
once the landing is resolved by simulation there is no arc to optimise, so
requiring players to look up 45° for full range would be a tax rather than skill.

Everything downstream already works: occupied tile, spiral to a neighbour, and
the `place_fail` refusal are all indifferent to how the position was reached.
Projectiles are rare enough (a player keypress) that ticking them off the
existing `item/tick` is not a performance concern.

## Open problems

### Blocking: a throw with nowhere to land

This is why the mechanic is parked.

The current drop path can fail safely **because it resolves instantly**. When
`try_place` exhausts its spiral it calls `place_fail`, which redraws the hand
from the carried record — and the record is still accurate, because no time has
passed.

A throw breaks that guarantee. During the ~1s of flight the player can pick up a
different resource, fill their hand to `$HandCap`, or die. "Give it back" is
therefore not available as a fallback, and the resource must either find a home
in the world or cease to exist.

The concrete failure: a throw lands in a 3×3 that is entirely occupied by piles
of other types at capacity. `try_place` checks the tile and its 8 neighbours and
gives up. Searching outward without bound is not acceptable — both for cost and
because it would fling resources arbitrarily far from where the player aimed.

Generalised, the rule this exposes is that **any action with latency between
commit and resolution needs a resolution that cannot fail.** That likely applies
to more than throwing.

### Option space for the landing problem

None of these have been evaluated; they are recorded so the next pass starts
from a list rather than a blank page.

1. **Bounded search, then destroy.** Simplest. Loses material in a game where
   material is the economy, which may or may not be tolerable if the radius is
   generous enough to make it rare.
2. **Bounded search, then a loose pile.** Let it rest wherever it physically
   landed, not tile-aligned. Breaks the one-pile-per-tile invariant, but only in
   rare cases, and could be visually distinct so players understand it.
3. **Relax tile capacity.** Allow a tile to exceed `$HandCap`, or to hold mixed
   types, as an explicit overflow state. Cheapest in code; changes the pile model
   everywhere.
4. **Refuse at launch.** Precompute a destination and disallow the throw when
   none is reachable. The only option that never loses material and never breaks
   the invariant, but it gives up the simulate decision above and is
   stale-terrain prone.
5. **Hold in limbo on the player**, re-entering the record when room appears.
   Invisible state; probably confusing.
6. **Bounce and roll.** On failing to land, keep travelling at reduced distance
   until a spot is found, against a hard step budget. Most in keeping with the
   machinery already being built for flight, and self-explanatory to the player.
   Degenerates into option 1 or 2 when the budget runs out.

### Smaller unresolved questions

- **Water.** The play area uses waterlogged stairs, so the per-step block check
  needs an answer for whether a thrown resource skips off the surface, sinks, or
  lands on it.
- **`place_fail` semantics after a delay** — see above; the current
  return-to-hand behaviour is not valid for any deferred action.
- **Throw vs walk balance.** With a 5-block cap and the spiral fallback,
  throwing reads as a distribution tool rather than transport, which seems right,
  but it has not been played.
