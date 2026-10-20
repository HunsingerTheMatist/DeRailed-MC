# Zombie Emerging

Written 2026-10-19. A zombie climbs out of the ground the way a warden emerges,
drawn by one item display stepping through a model a tick. The animation and
its look are working; its sounds are half done and paused (see "Sounds" below).

## Running it

`/execute positioned ^ ^ ^3 rotated ~ 0 run function derailed:emerge/zombie`, run
where the zombie is to stand, facing the way it is to face.

## How it works

- `emerge/zombie` summons an item display tagged `dr_emerge`, at twice the
  model's size and lit as the open sky lights it so it is not drawn black while
  underground. Its item is `derailed:zombie_emerge` with `custom_model_data`
  float 0.
- `emerge/_tick`, run each tick from `tick`, counts `dr_emerge` up and sets the
  item's `custom_model_data` from it through the item modifier
  `derailed:emerge_frame` (26.3 names a loot function with `type`, and a score
  has to go through `minecraft:from_int` to be a float). After the last frame,
  as many as `emerge/_frames` returns (written by the bake, 126 now),
  `emerge/_out` puts a real zombie in its place, facing its way.
- `emerge/_dig` throws up eight specks a tick of the ground block for the first
  4.5 seconds, and plays the dig sounds (below).

One entity and one command a tick: lighter than a rig of a display per bone, as
Animated Java builds, though it changes pose only 20 times a second.

## The animation

`utils/zombie_emerge.bbmodel` is the animation: a Blockbench Generic Model with
the zombie's bones, boxes and texture and an animation called `emerge`. Open it
in Blockbench (File, Open Model), change it in the Animate tab, save, then run
`py -3 utils/generate_zombie_emerge.py` and reload resources (F3+T) to bake it
into the frames, `models/item/zombie_emerge/000.json` on, and the item that
picks between them. Blockbench's bone keyframes mean what the game's do, so its
numbers carry over as they are, and the baking blends them as Blockbench does,
Bezier handles and all (Catmull-Rom wins over Bezier where either keyframe asks
for it), so the frames are what Blockbench plays.

`--from-warden --force` writes the project afresh from the warden's own emerge
keyframes (`utils/warden_emerge.json`, from the 26.3 client) with the zombie's
changes, which throws away any edits made in Blockbench. The changes, near the
top of the script:

- `SCALE`: the warden's moves scaled to the zombie's height.
- `MOVES_FROM`: only the body moves; the arms and head keep their places on it
  and the legs move with it, so nothing parts at the joints.
- `HANDS_DOWN`: the zombie's arms are shorter than the warden's, so from 3.1 to
  5 seconds the body is let down until its hands reach the ground.
- `STAND` and `BEND`: from 5 seconds the hips stay over the feet, so the stiff
  legs stand still instead of gliding, and the body bends 95 degrees with its
  arms straight down and its head tucked.
- `RISE`: when the body starts to straighten and the head to lift, together, as
  one movement; set to `STAND`, so it rises as soon
  as it is on its feet, with no hold bent over.
- `ZOMBIE_ARMS`: as it straightens the arms come up from hanging to the way the
  game holds a zombie's arms when it is after nothing, 80 degrees forward and a
  little in, which the real zombie taking over then holds too.
- The stand-up is written as a keyframe every `STEP` (0.1) seconds, each part
  eased in and out, so it reads as natural rather than stiff: the body takes
  `STRAIGHTEN` (1) seconds to straighten, and the animation ends `SETTLE` (0.25)
  seconds after, at 6.25 seconds, once the head and arms are done; it reaches
  upright tipping `OVERSHOOT` degrees back
  past it and settling back then (0, so it stops at upright), and sways `SWAY`
  degrees side to side; the head lifts `HEAD_LAG` seconds behind
  the body, nods `NOD` degrees as it settles (0, so it lifts straight to
  level) and tilts `TILT` degrees partway
  up; the arms rise `ARM_LAG` behind the body, the right before the left. All
  of it ends as the zombie stands, for the hand-over. In Blockbench that
  stretch is a row of linear keyframes; the settings reshape it all at once.

## Sounds

What plays now:

- `emerge/_dig`, every fourth tick for the first 4.5 seconds: the ground block's
  sound, `block.grass.hit` on grass and the break sound of the others (gravel on
  dirt, podzol, coarse dirt and gravel; moss, sand, stone), at volume 1 pitch
  0.9, with `block.rooted_dirt.hit` at volume 0.6 pitch 0.5 as a rumble under it.
- `entity.zombie.ambient` as its head breaks the surface, frame 16, and again
  as the real zombie takes over.

What is wanted instead:

- **The main part:** a changed version of the camel husk standing up,
  `entity.camel_husk.stand`, which plays one of `mob/camel_husk/stand1` to
  `stand5`.
- **The end, once out:** a changed version of the husk converting to a zombie,
  `entity.husk.converted_to_zombie`, which plays `mob/husk/convert1` or
  `convert2` at volume 0.8. `convert2` is the one liked, but it has a sound in
  it to take out, heard best in `husk2_no_low` (everything under 400 Hz taken
  away), running from the start to about three quarters of the way through.
  Not found yet.

Tried on the husk sound, none of them the right part:

- `whoosh`, the burst of the first 0.85 seconds alone; `tone`, the tail from 0.7
  seconds alone; `no_low` and `whoosh_no_low`, under 400 Hz taken away.
- `husk2_notch`, narrow cuts round the steady tones over 400 Hz, which are at
  about 1263, 2177, 2770 and 2820, 5510 and 5560, and 6844 Hz.
- `husk2_untoned`, the steady tones over 400 Hz taken out by setting what runs
  along in time against what spreads across pitch, which the spectrogram shows
  gone, leaving the burst and the low band.

So the unwanted part is likely in the noisy burst rather than the tones: the
spectrogram shows short rising blips in it, at about 0.1 seconds between 250 and
700 Hz and at 0.4 to 0.7 seconds between 900 and 1700 Hz, which may be it.

How the testing is set up, all of it to come out before the pack ships:

- `resourcepack/assets/derailed/sounds.json` holds test events, each playing one
  sound, for `/playsound derailed:test.<name> master @s`: `camel_husk_stand1` to
  `5`, `explode1` to `4` (the lightning strike's sounds), `husk1` and `husk2`
  (the vanilla husk sounds), and each changed husk sound by its file's name.
- The changed husk sounds are in `resourcepack/assets/derailed/sounds/test/`.
- The work was done in Python with `soundfile` (it reads and writes `.ogg`),
  `numpy` and `scipy`, in a throwaway environment, not installed for good; the
  vanilla sound files come out of `.minecraft/assets/objects` by the asset index
  (`assets/indexes/32.json` was the newest there; 26.3's own was missing).

Next: pick the camel husk file to start from and how to change it, find and
take out the unwanted part of `convert2`, make both proper sound events in
`sounds.json` in place of the test ones, play them from `emerge/_tick` and
`emerge/_out` in place of the dig sounds and groans as wanted, and take out the
test sounds.
