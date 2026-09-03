# Right-Click Detection & Dummy Items (Minecraft Java, data packs)

Reference notes distilled from three conure512 videos, captured 2026-08-27 while
working on DeRailed (MC 26.2). Written to be self-contained — safe to hand to a
fresh model instance with no other context.

Source videos:
- *I was wrong. Right Click Detection is here. For real.* — the three detection patterns
- *What is the Best "Dummy" Item in Minecraft?* — items with zero inherent behaviour
- *Right Click Detection just got 10x better* — the `consumable` component overhaul

---

## 1. The foundation

Give an item `minecraft:consumable` with a very large `consume_seconds`. The player
can then hold right-click indefinitely without the item ever being consumed, and the
`minecraft:using_item` advancement fires **every single tick** while the button is
held.

A high enough `consume_seconds` also suppresses the eating animation — the item never
travels toward the mouth, so it looks like holding right-click on any ordinary item.

That per-tick firing is both the problem and the opportunity: you cannot make the
trigger fire once, so you debounce it yourself.

---

## 2. The key scheduling fact

> **A granted advancement stops ticking. Revoking it makes it eligible to fire again.**

This is what makes cooldowns free. A `minecraft:tick` advancement that is normally
*granted* lies dormant and costs nothing. Revoke it and it fires next tick, runs its
reward function, and is granted again — so it ticks exactly as many times as you
choose to revoke it. No permanent per-tick loop, no `@a` scan.

Everything below is built out of this one fact.

---

## 3. The three patterns

### Continuous — acts every tick while held

The use function revokes its own advancement and does the thing. That is all. This is
the default behaviour if you do nothing special.

### Rate-limited / "burst" — acts every N ticks while held

The use function does **not** revoke its own advancement. It acts, then revokes a
separate `minecraft:tick` cooldown advancement and sets a cooldown score.

While the cooldown counts down, the use advancement stays *granted*, which means it
cannot detect anything — that is what enforces the gap. The cooldown function
decrements each tick and re-revokes itself; when it reaches zero it revokes the use
advancement, re-enabling detection.

N = 4 approximates the vanilla carrot-on-a-stick repeat rate. Higher values give a
deliberate long cooldown.

### Impulse — acts once per press, re-arms only on release

**This is the pattern for "fire on press, reset on release".**

The use function *does* revoke its own advancement every tick, so it keeps running
throughout the hold. It also revokes the cooldown advancement. But it only performs
the action if the cooldown score is absent/zero, and it sets that score to N at the
end of every tick.

So while the button is held the score is continually refreshed and never reaches zero
— the action fires only on the first tick. On release the use function stops running,
nothing refreshes the score, the cooldown ticks it to zero, and the item re-arms.

Sketch:

```mcfunction
# use function - runs EVERY TICK while held
advancement revoke @s only <ns>:use          # so it can fire again next tick
advancement revoke @s only <ns>:cooldown     # wake the ticker
execute unless score @s cd matches 1.. run function <ns>:on_press
scoreboard players set @s cd <N>             # refresh AFTER the edge check
```

```mcfunction
# cooldown function - reward of a minecraft:tick advancement
execute unless score @s cd matches 1.. run return 0     # dormant; also covers join
scoreboard players remove @s cd 1
execute if score @s cd matches 1.. run return run advancement revoke @s only <ns>:cooldown
scoreboard players reset @s cd
function <ns>:on_release
```

**Sizing N:** it must exceed the gap between trigger fires, or the cooldown expires
mid-hold and re-fires. `using_item` fires every tick, so N=2 suffices. Repeating block
placement / spawn-egg use only fires every ~4 ticks, so N=6 covers both. Larger N
means a proportionally later release edge.

---

## 4. Component syntax (1.20.5+ / current)

The `food` component **no longer makes an item edible**. It only defines stats.
Consumability moved to `minecraft:consumable`.

```
consumable={consume_seconds:100000, animation:none, has_consume_particles:false, sound:...}
```

- `consume_seconds:0` is now legal — instant consume, which pairs with the
  `minecraft:consume_item` trigger for clean one-shot detection.
- Particles and sound are now configurable. Both used to be hardcoded, which is why
  instant-consume items previously sprayed particles and made eating noises.
- `animation` sets the hand pose: `none`, `eat`, `drink`, `block`, `bow`, `spear`,
  `crossbow`, `spyglass`, `toot_horn`, `brush`. Most look janky in first person —
  `none` is usually what you want.
- If you keep the `food` component you **must** set `can_always_eat:true`, or the item
  only works when hungry or in creative.
- If you drop `food` and use only `consumable`, it behaves as always-usable by default
  (counter-intuitive but convenient).

### `use_cooldown` is useless for held items

The `minecraft:use_cooldown` component works well for genuinely consumable items — it
gives the vanilla hotbar cooldown sweep. But for an item you hold right-click on, **the
cooldown does not start until you release.** That is the opposite of what both the
burst and impulse patterns need. Use the advancement technique above instead.

---

## 5. The movement slowdown

While "using" a consumable, the player is slowed, because the game thinks they are
eating. The videos treat this as an unavoidable cost, offering only carrot-on-a-stick
or the knowledge-book method as alternatives.

**This is now fixable.** Newer versions expose a `use_effects` component:

```
use_effects={can_sprint:true, speed_multiplier:1}
```

Field names verified correct on 26.2. Not applied in DeRailed only because the
slowdown did not matter there — the component itself works as written.

---

## 6. Dummy items — items with zero inherent behaviour

Data packs cannot add new items, only re-skin existing ones. So the question is which
base item has the least behaviour of its own to fight against.

**Ruled out, with reasons:**

| Candidate | Why it fails |
|---|---|
| Brick | Crafts into brick block, flower pot, decorated pot |
| Echo shard | Crafts into recovery compass |
| Apple (food removed) | Still crafts into golden apple |
| Any wooden tool | Furnace fuel |
| Any iron/gold tool | Smelts into nuggets |
| Any diamond tool | Smithing-upgrades to netherite |
| Axe | Strips logs — hardcoded, survives component removal |
| Shovel | Creates paths — hardcoded |
| Hoe | Creates farmland — hardcoded |
| Sword | Sweep attack — hardcoded |
| Fishing rod, flint & steel, shears, brush | Have their own right-click behaviour |
| Armour-slot items | Equippable |
| Most foods | Compostable, plantable (carrot, potato), fed to mobs (rotten flesh to wolves), or villager trades (tropical fish) |

**Three items that actually work:**

1. **Stone or netherite pickaxe**, with `tool`, `max_damage`, `damage` and
   `attribute_modifiers` removed. Pickaxes are the only tool class with no hardcoded
   right-click behaviour. Removing `max_damage`/`damage` also makes it unenchantable,
   handling that edge case for free.
2. **Poisonous potato** with `food` removed. The only food in the game that is neither
   compostable nor plantable nor accepted by any mob or villager.
3. **Music disc** with `jukebox_playable` removed. Discs became data-driven in 1.21, so
   playability is just a component. Bonus knobs: `rarity` to fix the blue name colour,
   `max_stack_size` to make it stack.

---

## 7. Practical notes

- Detection advancements need no `display` block — without one they are invisible and
  produce no toast.
- Every detection advancement's reward function must revoke it (or a partner
  advancement) or it fires exactly once, ever.
- Advancement changes apply on `/reload`. Dimension and worldgen changes do not — those
  need the world closed and reopened.
