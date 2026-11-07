# Day and night

Written 2026-11-06, when the cycle was built. How the game dimension's day
runs, how the night is drawn, and what to check after a Minecraft update.

## The day

The dimension runs on the clock `derailed:game` and the timeline
`derailed:game_day`, both teams on the same clock. The day is 12000 ticks, ten
minutes:

| ticks | |
|---|---|
| 0 to 6700 | day |
| 6700 to 8200 | dusk, 75 seconds |
| 8200 to 10500 | night |
| 10500 to 12000 | dawn, 75 seconds |

Each fade follows a cubic Bezier of its own: dusk darkens early, and dawn
brightens late. The timeline fades the ambient light to `#010101` and the sky,
fog, water fog and clouds to black, and brings the stars out. Time markers
`derailed:day`, `dusk`, `night` and `dawn` work with
`/time of derailed:game set`.

`utils/generate_day_timeline.py` writes the timeline and `light/curve`. That
function holds the fade ticks as constants and how dark it is, 0 to 255, at each
tick of dusk and dawn, so change the day there and nowhere else.

## The night

### Without the resource pack it is black

The ambient light is all the light the dimension shows, so the timeline fading
it to `#010101` leaves nothing to see. The dimension type has sky light, which
the weather needs, but its `visual/sky_light_factor` is 0, so sky light never
lights anything. `#010101` rather than black, because the brightness option
divides by the strongest channel.

### With it, the pack draws the darkness

- **`lightmap.fsh`** is vanilla's, but in the game dimension it takes the
  ambient light as full, whatever the clock has it at. It knows the dimension
  by its block light tint, `#ffd88d`, one off vanilla's `#ffd88c`, which no
  timeline fades.
- **The lights** are item displays with the `derailed:light_marker` model,
  glowing:
  - one teleported to each player's eyes every tick, reaching
    `$PlayerLight` (15) blocks. `/ride` refuses to mount anything on a player;
  - one riding each piece of a train, 1.5 blocks over the track, reaching
    `$TrainLight` (9).
  - `light/tick` keeps them and gives each its own slot of 32.
- **The glow colour** carries a light's data:
  - red is how dark it is;
  - green is its slot;
  - blue is how far it reaches.
- `light/tick` reads the tick of the day each tick and rewrites every light's
  glow colour when how dark it is changes.
- **`rendertype_outline.vsh`** spots a light by its texels, whose alpha is
  exactly 1/255. It draws each of the model's faces onto one pixel of the
  outline buffer's bottom row instead of where it stands.
- **That row** holds:
  - the projection;
  - a check colour;
  - how dark it is;
  - where each light is from the camera, and how far it reaches.
  - The comment at the top of the shader lays it out.
- **`post_effect/entity_outline.json`** runs `derailed:post/night` first.
  - It works out where each pixel is from its depth and the projection.
  - It darkens it by how dark it is, but where a light reaches.
  - A light is full out to half its reach (`FULL`) and fades to nothing at it.
  - The sky is left alone.
  - `outline_clean` then clears the data row so vanilla's outlines never draw it.
- **The outline chain** only runs while something glows, which the lights see
  to.

Depth in 26.3 runs from 1 at the near plane to 0 far away, and the projection
can map it to 0 to 1 or -1 to 1. `night.fsh` tells them apart by m22.

### The block highlight

The highlight is drawn before the night effect and writes its own depth. So
where its lines cross faraway ground, that ground shows through the line, lit as
if it were the highlighted block. `rendertype_lines.fsh` makes the highlight more
opaque as night falls, from vanilla's 40% to 75% (`NIGHT_ALPHA`), which leaves a
quarter of the sliver showing. It reads how dark it is from the fog colour,
which the day fades to black. So underwater, and in rain, the highlight is a
little darker than the time of day alone would make it.

## After a Minecraft update

These replace vanilla files, so compare each with the new version's:

- `assets/minecraft/post_effect/entity_outline.json`, the vanilla chain with
  the night passes added round it
- `assets/minecraft/shaders/core/rendertype_outline.vsh` and `.fsh`
- `assets/minecraft/shaders/core/lightmap.fsh`
- `assets/minecraft/shaders/core/rendertype_lines.fsh`

Also check that:

- depth still runs from 1 near to 0 far;
- post shaders can still read the main depth buffer (`use_depth_buffer`);
- the outline pipeline still draws glowing entities with `ModelViewMat` as the
  camera's rotation.

## Limits

- 32 lights; anything past that gets none
- The projection is passed within 8 of 0, which a spyglass's zoom passes
- Night vision lights the world without the pack too, since vanilla lets it
  overrule a dark ambient light
- A pack edited to keep `lightmap.fsh` and drop the night pass sees in the dark
- Not tried under Sodium
