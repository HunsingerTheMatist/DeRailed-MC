# Weather

Written 2026-11-07, when rain was built. The only weather is rain; snow is for
when there is a snow biome.

## Turns

`weather/tick` runs the weather in turns of `$WeatherTicks` (500, 25 seconds).
Each turn's weather is rolled a turn ahead, rain `$RainOdds` times in 10000
(1667, 1 in 6), so a rain knows whether the turn after rains too.

The game's own rain shows it. The gamerule `advance_weather` is off, so the
weather only changes when `weather/tick` calls `weather rain` and `weather
clear`, and `/weather` is server-wide, so the overworld rains with it.

## Strength

`#rain` in `dr_var` is the rain's strength, 0 to 100. It grows 1 a tick from the
start of a rain turn and, where the next turn is not rain, dies away 1 a tick
over its last `$RainFade` (100 ticks). The game's own rain level moves a
hundredth a tick, so calling `weather rain` at the start of the turn and
`weather clear` as it starts to die away keeps the two together. Rain followed
by rain keeps full strength.

## What rain does

While it rains, each piece of a train and each empty bucket on the ground is hit
`$RainHitChance` times in 10000 a tick at full strength (125, about once every
four seconds), scaled by the strength (`weather/_roll`).

- **A hit on a piece of a train** cools every piece of that train
  (`weather/_cool`): `$RainCool` ticks (60, three seconds' worth) off its heat,
  and off the water wagon's water used. A burning piece cooled below what it
  takes to catch goes out, the water wagon once it has water again. Since each
  piece is hit on its own, a longer train is hit more often
- **A hit on an empty bucket** fills it, its display drawn full, without a sound
  (`weather/_fill`). A bucket in a hand does not fill

## Running and resetting

The weather only ticks while `#weather_on` in `dr_var` is 1, and otherwise keeps
still as it is, the game's rain included.

`weather/reset` puts the weather back to how a run starts: clear at once, the
turn starting now clear and `$WeatherClearStart` long (600 ticks, 30 seconds),
and the turn after it rolled as any is. A run starting calls it and then sets
`#weather_on` to 1. The first load runs it and leaves the weather still; a
reload after that leaves the weather as it was.

Dev commands in `dev/weather/`: `start` resets the weather and sets it going,
`stop` keeps it still, `rain` makes the turn starting now rain, and `clear` stops
any rain at once.

## The dimension

Rain needs the dimension type to have sky light and no ceiling, and the biome
to have precipitation. `derailed:game` has `has_skylight` on with
`visual/sky_light_factor` 0, so sky light never shows (see `day_and_night.md`),
and the `derailed:game` biome has `has_precipitation` on at a temperature of 2.0,
warm enough for rain rather than snow.
