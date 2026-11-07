# To Do

Written 2026-10-29. Everything known to be left before the game is finished,
to pick what comes next from. Tick an item off when it is done, and add to it
as things come up.

Sizes are rough: **S** an afternoon, **M** a few sessions, **L** a system of its
own. **(brief)** marks something only the design brief asks for, kept here to
keep or drop; **(suggested)** marks something nothing asks for yet but a
finished run seems to need. **Undecided** items need a design call before
building.

## Where things stand

The systems are real: the train follows laid track, mining, piles, throwing,
auto pickup, rail laying and ghosts, terrain generation and the full-size
builder all work. What is missing is mostly what joins them into a game:
nothing outside `dev/` starts a run, spawns a train, builds terrain or puts
players in the game dimension.

## A run you can play

- [ ] **Entering the game** (S). Put players into `derailed:game` with a
  spawnpoint, and move the forceloads gameplay needs out of `dev/bench/load`
- [ ] **Starting a run** (M). Build the first section, lay the starting track,
  spawn the train, put the tools down, and set the weather going from how a run
  starts (`weather/reset`, then `#weather_on` 1). Needs: entering the game; a
  section to start on (`dev/big` can stand in until terrain is built in play)
- [ ] **Tools in the world** (S). Axe, pickaxe and bucket put down as piles at
  the start. Nothing gives or places them today
- [x] **Deposits** (M). Clicking the supply wagon with wood or iron puts it in,
  and crafted rails can be taken out. The train's `dr_train_click` interactions
  have no handler yet
- [x] **Crafting wagon** (M). Turns a wood and an iron into a rail on a timer.
  Needs: deposits
- [x] **Running out of track** (S). The train stops for good at the end of its
  track, through the hook `train/derail`
- [ ] **What a derail does** (S–M). Feedback when a train derails, a sound,
  particles or a title for its team, and what it costs, which hangs on
  'Derailing and the end of a run'; both go in `train/derail`
- [x] **Water and fire** (M). See "Fire" in `trains.md`
- [x] **Bucket on the map** (S). `dev/big/build` lays a `dr_water` interaction
  over every water tile
- [ ] **Bridges** (M). Putting wood on water lays a bridge
  (`item/event/interacted_water` TODO, `item/bridge/try_place_wood`, the unused
  `bridge` structure)
- [x] **Taking the last rail back** (M). An empty hand takes the end's rail,
  refused while the train is on its tile. See `track_end_tracking.md`
- [ ] **Reaching a station** (M). The train arriving stops the run between
  sections and the next one begins. Needs: terrain built in play
- [ ] **Derailing and the end of a run** (M). Lives, what a derail costs, game
  over, and putting everything back for the next run. Undecided; the brief
  suggests losing a life and half the gold and going back to the section start
- [ ] **Respawning** (S–M). Back at the front of the train, which doubles as
  getting unstuck, and a rescue for anyone under the ground (brief). Players
  also need a way to respawn themselves on purpose: a `trigger` command, an
  item they use, or an item kept in the inventory that they throw out or click
  in some way that can be detected. Undecided which
- [ ] **Death** (S). `keep_inventory` is on, and the inventory check gives the
  saddle back whenever it is missing. Still to come: what dying costs, and
  where the player comes back (see Respawning)
- [ ] **Healing near the train** (S). Natural regeneration off, players heal
  within some distance of the train
- [ ] **Train speed over a run** (S). `$TrainSpeed` is constant; speeding up
  over a run, or with track laid ahead, is the usual pressure (suggested)

## Terrain in play

- [ ] **Sections built ahead of the train** (L). The queue builds plan
  sections only in the test area; in play one has to be built out of sight
  and brought in before the players reach it
- [ ] **Full-size builder out of `dev/`** (M). `dev/big` builds one section at
  fixed coordinates; it needs to build any section where the run has reached,
  making the mining markers as it goes. Placeholder plan blocks become real
  blocks here
- [ ] **Queue's last-resort safety net and tick budget** (M). Loosen only the
  checks that hang on the section before; pack several cheap steps into a
  tick
- [ ] **Where the station goes** (L). Every section ends in its station, at
  the exact end of the section. It should be placed so the next station does
  not always sit at the section's end, which reaches into how sections join,
  the routes and the station prefab. Undecided how
- [ ] **Confirm every section has a second route** (S). Count fresh starts over
  batches and check none ships without one
- [ ] **Polishing the rivers and lakes** (M). Their saved structures, bends and
  how they meet the bank, reworked with the help of Minecraft builders
- [ ] **Cows** (M). Placed by the generator as plan blocks only; what they do
  in play is undecided
- [ ] **More biomes** (L). Grass is the only one. Snow first needs the snow
  slowdown and a new block for pile collision, which uses snow layers today
  (see the snow plan). The brief warns iron reads poorly on sand-toned ground
- [ ] **Reachability** (L). Designed in `reachability.md`, not built. Decide
  whether it is still needed now the pile search and routes cover much of it

## Threats

- [ ] **Bandits** (L). A design of their own, acting quite differently from
  the usual train thieves, and climbing out of the ground with the zombie
  emerge animation. The generator places bandit pieces as plan blocks; the
  animation works, but nothing calls it and what climbs out is a vanilla
  zombie. When and where they come up, and what they go after, is undecided
- [ ] **Zombie emerge sounds** (S–M). Paused; see `zombie_emerge.md`

## Players and items

- [ ] **How the hotbar is shown** (S–M). Undecided, with ideas to talk through
- [ ] **Inventory lock** (S). Only the main hand is checked; the 2×2 crafting
  grid and the cursor slot can still hold items (brief)
- [ ] **Sweet berries** (S–M). Undecided; see `sweet_berries.md`
- [ ] **Dash** (S). Built, with its tick hook commented out. Keep it for the
  berries, put it back on sprint, or delete it
- [ ] **Tools glow** (S). So they can be found in first person (brief)
- [ ] **Every refusal gets a sound and a message** (S). `item/new_placement`
  still says `Error!` (brief)
- [ ] **Pile size TODO** in `placement/update_placement` (S). Check whether it
  is still open

## What players can see

- [ ] **Which HUD** (L). Undecided: the brief's map framebuffer (`$MapEnabled`
  0, `player/fix_map` empty) or the font HUD tested in `dev/hud`
- [ ] **The HUD map follows the world** (M). It is drawn once and does not
  change when the world does: a tree mined, a pile put down or taken, a rail
  laid. Needs: which HUD
- [x] **Rain** (M). Turns of weather with rain one in six, cooling the train and
  filling buckets on the ground. See `weather.md`
- [x] **Day and night** (M). A ten-minute day with pitch-black nights, lit
  round each player and each piece of a train. See `day_and_night.md`
- [ ] **Day and night under Sodium** (S). Check the night effect and the
  lightmap override still work with Sodium installed
- [ ] **Water and time before derailing** (M). The two numbers players act on
  (brief). Needs: the HUD
- [ ] **Where the tools are** (M). On the HUD (brief)
- [ ] **Run progress** (S). Distance, sections reached, perhaps a bossbar (brief)

## Progression

- [ ] **The shop** (L). Undecided and the largest open design question: the
  currency, where and when it is spent, and what it buys
- [ ] **Changing the train** (L). Adding wagons, rearranging them and upgrading
  them, and wagons beyond the water, supply and crafting wagons. The train is
  spawned with the engine and those three in a fixed order today. Bought at
  the shop
- [ ] **Difficulty across a run** (S). The generator has three tiers; which
  section of a run gets which

## Multiplayer

- [ ] **Two teams, two trains** (L). The train and the track are kept for each
  team, red and blue, `dr_team` on everything a team owns (see `trains.md`).
  Still kept once for the whole game: the map's bounds and section queue. How
  the teams share or split the map is undecided
- [ ] **Joining a run in progress** (S). Only an id and a starting wood today
- [ ] **A four-player playtest and profile** (M) (suggested)

## Before release

- [ ] **Debug messages to `@a`**: `player/check_inventory` (two),
  `item/event/item_dropped`, `dev/gen/queue_tick`; and `#say Water` in
  `item/event/interacted_water`
- [ ] **Commented-out leftovers**: `item/event/interaction_used`,
  `item/bridge/try_place_wood`, the boat `give` in `player/fix_items`
- [ ] **The starting wood** in `player/init`
- [ ] **Test and rejected assets**: `sounds/test` and its `sounds.json`
  entries, the `tests` models, textures and blockstates, `items/rejected`,
  `models/item/_rejected`, the `tests` loot tables, `_unused_glass`
- [ ] **`dev/` out of the release** (S). `utils/build.py` zips everything, and
  `load` runs the dev loads, whose `max_command_sequence_length` overrides the
  game's own
- [ ] **Packaging** (S). `metadata.json` (still 26.2, empty summary), the
  README, the changelog, a first 26.3 build, and requiring the resource pack
- [ ] **`todo.txt`** at the root holds only block hitbox sizes; fold it into a
  note or delete it

## Suggested next

The shortest way to something playable, on one `dev/big` section before terrain
is built in play: entering the game, tools in the world, deposits and crafting,
running out of track, then water, the bucket and bridges. That makes the core
loop testable end to end, and each later item lands on top of it.
