# DeRailed — Design Brief

> **Status:** Initial design exploration, not a specification. Decisions made
> during implementation supersede this document. Sections here have not all
> been reviewed or agreed to.

## What this is

A Minecraft **datapack + resource pack** minigame (Java Edition, vanilla server, no mods)
inspired by *Unrailed!*. A train advances continuously along a track; players gather wood
and iron, craft rail segments, and lay track ahead of it. If the train runs out of track,
it derails.

This is **not a faithful port**. Unrailed is a 2D top-down game; Minecraft is first-person
and 3D. The design deliberately reinterprets mechanics that only existed because of the
original's perspective, while preserving the core: *something advances on its own, it dies
if unsupported, and building the support takes more hands than you have.*

Players play in **first person**. There is no external camera — Java has no camera control
API, and spectator-based workarounds block interaction.

---

## The map is the game's screen

This is the most unusual part of the architecture and everything else depends on it.

Players hold a **filled map, force-locked to the offhand**, all sharing one map ID. The map
is not a mirror of where players are standing — it is a **framebuffer**. A dedicated region
of the world is drawn to, and the map renders that region.

### Geometry

| Thing | Size |
|---|---|
| Map | 128 × 128 px |
| Tile | 5 × 5 px |
| Stage (play field) | 64 × 16 tiles |
| Visible window | 25 × 16 tiles = 125 × 80 px |
| Title band (top) | ~20 px, static |
| HUD footer (bottom) | ~24 px |

The window pans **horizontally only**. Field height equals window height, so vertical
terrain is always fully visible — only forward reveal is fogged. Fog is achieved by the
window edge, not by blacking out pixels.

### Rendering pipeline

1. **Source region** — the entire stage rendered at 5×5 px per tile (320 × 80 blocks).
   Static; only touched when terrain actually changes (tree chopped, rail placed, item
   dropped). A single tile edit is 25 blocks.
2. **Display buffer** — the 125 × 80 region the map actually reads.
3. **Scroll step** — one `/clone` of a 125 × 80 window from source into buffer, offset by
   one more pixel. 10,000 blocks, under the 32768 clone volume limit. Scrolling is 1px
   increments; 5 steps per tile of train travel.

Do **not** redraw the buffer pixel by pixel. Clone is the whole point — it makes detailed
5×5 sprites free.

### Implementation requirements

- All buffer writes go through a **single `setPixel(x, y, color)` abstraction**. Do not
  scatter `/setblock` through terrain logic. This is the seam where dirty-tile batching,
  biome palettes, and any future staircasing would live.
- Use a **dirty-tile queue plus periodic full reconcile**. A silently stale buffer is a
  wrong board with no visible symptom — make it self-healing rather than event-driven.
- The buffer must sit within **128 blocks of players** or pixels won't update. Place it
  directly above the play area in the same X/Z footprint, at a different Y.
- The buffer must cover the **full 128 × 128**, or uncovered columns show the real world
  underneath. Letterbox bands handle the top/bottom.
- Put **light blocks** (map color NONE) between the buffer and the play area so the buffer
  can be opaque without darkening the world below.

### Map decorations

The `minecraft:map_decorations` item component provides icons. It takes `type`, `x`, `z`
(world coordinates, doubles), and `rotation`. **There is no name field.**

Used for: players, the train, tools (axe/pickaxe/bucket), and the destination station.

Because the play field and the buffer are different regions, **vanilla player markers would
appear in the wrong place**. Blank the `player`, `player_off_map`, and `player_off_limits`
textures in the resource pack, and draw custom decorations at transformed coordinates
instead. This also allows per-player colors, which vanilla lacks.

Decorations accept doubles, so the train and player icons **glide smoothly** even though
terrain scrolls in 5 discrete steps per tile.

Updating: item components can't be `/data modify`'d in player inventories. Keep a master
map in a barrel, update it there via a macro function, then
`/item replace entity @a weapon.offhand from block <pos> container.0`. This piggybacks on
the offhand-enforcement loop that already runs.

Retexture the map decoration atlas to make markers look like an axe, pickaxe, bucket, etc.

---

## Palette

**Flat method only.** No staircasing — a pixel's shade depends on the block to its north,
so one edit cascades down its entire column. Not worth it for detail invisible at 5px.

Flat color = base RGB × 220/255 (floored). 61 colors available.

Currently used (16):

| Role | Hex | Base color |
|---|---|---|
| Ground / grass | `#6DB015` | COLOR_LIGHT_GREEN |
| Chrome background | `#151515` | COLOR_BLACK |
| Stone, impassable | `#414141` | COLOR_GRAY |
| Rock, mineable (base) | `#909090` | METAL |
| Rock, mineable (detail) | `#ABABAB` | WOOL |
| Tree canopy / grass tufts | `#006A00` | PLANT |
| Title, gold | `#D7CD42` | GOLD |
| Wood item / trunk | `#6F4A2A` | PODZOL |
| Iron item / HUD text | `#DCDCDC` | SNOW |
| Bridge / wood shade | `#A0721F` | TERRACOTTA_YELLOW |
| Water | `#4040FF` | WATER, shallow shade |
| Scaffolding | `#BA6D2C` | COLOR_ORANGE |
| Rail | `#565656` | DEEPSLATE |
| Ducks / highlight | `#C5C52C` | COLOR_YELLOW |
| Text highlight | `#DCD9D3` | QUARTZ |
| Station roof | `#842C2C` | COLOR_RED |

**Note on water:** `#4040FF` is the *brightest* water shade. Map rendering special-cases
water by **column depth**, not height — shallow water renders brighter. This is why it
doesn't match the flat formula. Keep all water 1 block deep for uniform color.

### Visual grammar

- **Full-bleed = terrain** (harvestable). **Inset with visible ground = item** (collectable).
  This is the board's most important invariant.
- **Texture carries meaning, not just hue.** Impassable stone is a flat dark mass;
  mineable rock is lighter with a cobble pattern. This survives at 5px where hue alone
  might not.
- **Terrain tiles need gutters** so adjacent tiles are individually countable. Trees do
  this well; **mineable rock currently does not and should be fixed** — players need to
  know whether a vein yields 4 or 9.
- **Items are 2×2 marks**, slightly off-center (5 is odd), stacked every 2px vertically.
  Overflow into the tile above is accepted, matching the original's occlusion behavior.
- **Rail items are two-tone 2×2** — light gray over brown, a miniature of rail-over-tie —
  so they stay visible against laid track, which is also dark.
- **Sprite variation must be derived from a hash of tile coordinates**, never a random roll
  at draw time. Otherwise sprites flicker when redrawn.
- Grass tufts break up flat green. Keep density moderate and suppress them near the rail
  line, where players hunt for dropped items.

### Biome caution

Item colors are tuned against green. `#DCDCDC` iron on sand-toned ground would be nearly
invisible — and desert is where iron matters most. Either constrain biome ground colors to
mid-lightness, or swap item palettes per biome.

---

## HUD

Three surfaces, each doing what it's good at:

- **Map footer** (core, always visible): boiler `WATER` bar with color shift, and
  `DERAIL: Xs` — seconds until the train runs out of track. Plus the distance ruler
  (from the original).
- **Scoreboard sidebar** (auxiliary): train speed in m/s, gold, distance traveled.
- **Bossbar** (auxiliary): stage progress.

Crafted-rail count is deliberately **omitted** — the crafting wagon is a physical object
with visible state, and reading it should stay someone's job.

**Verify before committing to `DERAIL: Xs`:** train speed is a function of track laid
ahead, so buffer time is `T / f(T)`. If `f` is near-linear, that ratio is nearly constant
and the readout won't respond to player action. Plot it across the real speed curve. If
flat, fall back to a plain `RAILS: N` count.

Title band is a static gold-on-black pixel font, drawn once per stage at fixed coordinates.

---

## World and movement

- **Terrain is 1 block tall.** Jump is disabled via a lowered jump attribute (not barrier
  ceilings), so a 1-tall block is impassable.
- Auto step-height still allows ~0.5, so **intended elevation changes must be slabs or
  stairs**.
- **Water is real water, 1 block deep**, below ground level. Players wade through with
  Slowness; they cannot swim. Water is impassable to the *train* and must be bridged with
  scaffolding. Bridge placement uses **interaction entities on water tiles**, not raycasts.
- Terrain generation must guarantee **at least 2 passable tiles at chokepoints** (one for
  the train, one for a player) — this is what the original does.
- **Respawn-at-front-of-train** serves as the unstuck mechanic and as a tactical option.
- A tick check should rescue any player below ground level.

---

## The train

The train does not ride rails. It is simulated: constant datapack-driven speed, unpushable
by players.

Per car, **three decoupled entities driven from one logical anchor**, each teleported to a
computed offset every tick:

1. **Block/item display** — visuals. Has real interpolation, so it looks smooth where a
   teleported minecart would stutter.
2. **Invisible shulker** — collision. Shulkers are the only vanilla mob that pushes players
   rather than being pushed. Set `NoAI`, invulnerable, silent, and **pin the peek state**
   (peek changes the hitbox; a train that breathes feels awful).
3. **Interaction entity** — the deposit hitbox. Records its last interactor, so deposits
   know who.

**Do not use riding stacks.** One entity culled or unloaded desyncs the whole car
unrecoverably. Do not use marker entities as mounts either — markers aren't sent to
clients, and player-entity collision is client-predicted.

Custom models come from the resource pack: geometry in `models/`, bound via the
`minecraft:item_model` component, rendered on item displays. Constraints: **cuboids only**;
each element rotates on **one axis** by ±22.5° or ±45°; element coordinates bounded roughly
−16..32. Anything angled outside that set needs its own display entity (entity
transformations accept arbitrary quaternions). Splitting cars into multiple displays also
enables animation via transformation interpolation (spinning wheels, rising water level),
and `brightness` overrides give a full-bright firebox.

Set `require-resource-pack=true` — without the pack, players see floating base items.

---

## Items and interaction

**Do not use vanilla item entities.** They merge into stacks (destroying countable piles),
despawn after 5 minutes, slide off ledges, and get vacuumed up by proximity. Use
**item displays** with a custom system.

Players hold **one item type at a time**, hand limit 3 resources. Enforce with a tick check
that nothing lives outside the held slot — **including the 2×2 crafting grid and the cursor
slot**, which is where inventory locks usually leak.

### Verbs

| Input | Action |
|---|---|
| **Q** | Deposit at derived tile. **Must always succeed** — this is the panic verb. |
| **Left click** | Pick up. |
| **Right click** | Place on an empty tile. |

- Compute the target tile from the **thrower's position and facing**, not the item entity's
  position — thrown items carry velocity and will have drifted.
- **Fallback search:** if the target tile is unavailable, spiral a 3×3 centered on it,
  starting in the look direction, **prioritizing tiles that already hold the same type**
  (empty tiles are the scarce resource near the crafting wagon). Bias toward the player.
  If nothing is found, fail loudly.
- **Targeting** has the opposite default: when a player aims at a specific tile, empty
  ground wins over merging into a pile.
- **The game moves resources, never tools.** A cross-type swap may auto-place the held
  stack nearby; a tool never auto-places. Tool-swap costs two inputs — this preserves the
  "you can't mine and haul simultaneously" tension the game is built on.
- Same-type-and-full swaps are a **no-op**.
- **Never silently ignore an input.** In first person a player can't distinguish a refusal
  from a miss. Every rejection gets a sound and a message.
- Interaction hitboxes should be **modest** (match the display footprint) to avoid
  absorbing left-clicks meant for mining.
- **Tools glow permanently** and appear as map decorations. Tool location is real
  information and is otherwise unrecoverable in first person.

### Mining

Vanilla mining (held left-click), no auto-mine. Two consequences:

- **Cancel vanilla drops** and spawn custom item displays instead.
- Block hardness can't be edited by a datapack — tune duration via the tool's
  `mining_efficiency` component and block choice.

Vanilla crafting recipes are disabled; rails are crafted from wood + iron at the crafting
wagon on a timer, as in the original.

---

## Progression and failure

- Each stage is one map tile's worth of field. Stages **build forward** — never reset and
  rebuild the same region. Rebuilding under a live map ID causes stale pixels, and forward-
  building avoids teleporting the train and players between stages.
- The station **straddles the seam** between stages, appearing at the trailing edge of one
  and the leading edge of the next.
- Stage length varies by station placement within the tile (128 straight across, up to ~228
  corner-to-corner), giving escalating stage length without breaking alignment.
- Terrain generation for the next stage runs during the **lobby phase** between stages.
- **Derail = lose a life, lose half your gold, rewind to stage start.** Do not strip wagons
  — that's a death spiral. The original wipes the entire run; that's too harsh for a server
  where players join mid-session. (The sequel added lives for the same reason.)
- Gold replaces bolts as currency.

---

## Open questions

Tune by playtesting, not by reasoning:

- Derail penalty severity and number of lives.
- **Where the train sits in the window** — this sets the planning horizon and is worth more
  than most other tuning. Start it further back than feels right.
- Obstacle density. With a 16-tall field there's no real routing game, so density is the
  primary difficulty knob.
- Pile cap per tile.
- Whether `T / f(T)` varies enough for `DERAIL: Xs` to be useful.
- Wagon roster, upgrade tiers, what gold buys, biome progression and effects.

---

## Verify these before building on them

Cheap to test, expensive to be wrong about:

1. **Clone-blit scrolling** — does a 125×80 `/clone` run smoothly at the intended scroll
   rate, and do map pixels update reliably at that distance?
2. **Shulker collision on a moving train** — does a teleported, `NoAI` shulker shove players
   correctly at speed, and does it hold a fractional position across chunk reloads?
3. **Item display drop/pickup** — does the full custom item loop feel responsive?
4. **Map decoration update cost** — how expensive is refreshing four players' offhand map
   items every tick?
5. **Interaction entity vs. item use** — confirm right-clicking an interaction entity while
   holding an item doesn't also trigger the item's own use behavior.
