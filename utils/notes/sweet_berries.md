# Sweet Berries

Written 2026-10-20. Undecided, to revisit. Clicking a sweet berry bush picks its
berries, which was never meant to happen. Rather than block it, the idea is to
make it a mechanic: the bush's loot table drops a custom item that does
something when used.

## What it should not do

Healing is not its job. Players heal by staying near the train, with no
natural regeneration, so the berries are better as a reason to leave the train
and bring something back.

## Supply

Random ticks are off in the minigame, so a picked bush never grows back. Every
bush is picked once, for however many berries its age gives, and the berries on
a map are finite. That leaves more room for a strong effect than an endless
supply would, and how many bushes the terrain places is the knob for how many
there are.

## Options

1. **Dash.** Using one throws the player forward. The impulse already exists:
   `player/dash` puts a `derailed:dash` enchantment in the saddle slot, and only
   its sprint-key trigger in `tick` is switched off. It helps only the one who
   eats it and only with moving, and over a run it may shrink the distances the
   map is built around. It shares the saddle slot with the planned snow
   slowdown, so the two would have to go on one saddle rather than replace
   each other
2. **Carry more.** For a while, or for the next few pickups, the hand holds more
   than `$HandCap`. It plugs straight into hauling wood and iron, and is felt
   without breaking anything
3. **Feed the train.** Thrown into the engine (throwing already exists), they
   slow the train or hold off overheating for a while. It helps the whole team
   and gives a real choice: time spent picking berries now against time bought
   later
4. **Plant a bush against zombies.** Used on the ground, it plants a young bush.
   A berry bush already slows and hurts mobs walking through it, so it counters
   the emerging zombies with little new code. It slows players too
5. **Bait.** Thrown, it draws nearby zombies to it for a few seconds, away from
   the track or the player laying rail
6. **Mine faster.** A short burst of Haste for chopping and mining. Simple and
   plain to read, but only a number going up
7. **Spend it.** A second currency, spent at stations on small upgrades. Works
   best if stations already have a shop

## Leaning

Feeding the train first, planting bushes second. Feeding the train helps
everyone and ties the berries to the train, which the rest of the game centres
on; planting gives the zombies a counter that already looks right. A dash works
but is the least tied to the rest of the pack.

## Building it

- Override `minecraft:harvest/sweet_berry_bush`, the loot table picking a bush
  drops, to drop the custom item. `minecraft:blocks/sweet_berry_bush` is what
  breaking it drops
- A use on right-click, either an instant `consumable` caught by a
  `consume_item` advancement or the existing right-click detection
