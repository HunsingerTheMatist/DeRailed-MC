"""Writes the game dimension's day, 'derailed:game_day', on the clock
'derailed:game': PERIOD ticks long, full day from 0, dusk from DUSK to NIGHT,
night from NIGHT to DAWN, and dawn from DAWN back round to full day at PERIOD.

At night the ambient light, which is all the light the dimension has but what
blocks give off, goes to AMBIENT_NIGHT, as near black as the brightness option
can lift without dividing by nothing; the sky, the fog in air and in water
and the clouds darken with it and the stars come out. The sun, moon and stars turn once a day, with noon at
NOON.

A timeline eases a whole track the one way, but dusk and dawn want their own
curves, so each fade is written as keyframes every STEP ticks along a cubic
Bezier of its own, DUSK_CURVE and DAWN_CURVE, given as CSS gives one: the
control points (x1, y1) and (x2, y2) of a curve from (0, 0) to (1, 1), x the
time through the fade and y how far the fade has gone. The brightness option
lifts dark colours hard, so a fade that darkens evenly looks lit until late;
dusk darkens early and dawn brightens late to look even.

It also writes 'derailed:light/curve', which keeps for the night post effect
the ticks the fades start and end at and how dark it is, 0 to 255, at each
tick of each fade, along the same curves.

Run from the repository root: py -3 utils/generate_day_timeline.py
"""

import json
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
OUT = ROOT / "datapack" / "data" / "derailed" / "timeline" / "game_day.json"
CURVE_OUT = ROOT / "datapack" / "data" / "derailed" / "function" / "light" / "curve.mcfunction"

PERIOD = 12000
DUSK = 6700
NIGHT = 8200
DAWN = 10500
NOON = 2600
STEP = 50

DUSK_CURVE = (0.0, 0.6, 0.4, 1.0)
DAWN_CURVE = (0.6, 0.0, 1.0, 0.4)

AMBIENT_NIGHT = "#010101"

# Each faded track: its value by day, its value by night, and how it combines
#  with the dimension's own
FADES = {
    "minecraft:visual/ambient_light_color": ("#ffffff", AMBIENT_NIGHT, None),
    "minecraft:visual/sky_color": ("#ffffff", "#000000", "multiply"),
    "minecraft:visual/fog_color": ("#ffffff", "#000000", "multiply"),
    "minecraft:visual/water_fog_color": ("#ffffff", "#000000", "multiply"),
    "minecraft:visual/cloud_color": ("#ffffffff", "#ff101018", "multiply"),
    "minecraft:visual/star_brightness": (0.0, 0.5, None),
}

# Vanilla's ease for things that turn round the sky
TURN_EASE = {"cubic_bezier": [0.362, 0.241, 0.638, 0.759]}


def bezier(curve, x):
    """How far a fade has gone at time x through it, along a CSS cubic Bezier"""
    x1, y1, x2, y2 = curve

    def point(t, a, b):
        return 3 * a * t * (1 - t) ** 2 + 3 * b * t * t * (1 - t) + t ** 3

    low, high = 0.0, 1.0
    for _ in range(60):
        t = (low + high) / 2
        if point(t, x1, x2) < x:
            low = t
        else:
            high = t
    return point((low + high) / 2, y1, y2)


def mix(a, b, f):
    """A value f of the way from a to b: a number, or a colour '#rrggbb' or
    '#aarrggbb'"""
    if isinstance(a, float):
        return round(a + (b - a) * f, 4)
    ca = [int(a[i:i + 2], 16) for i in range(1, len(a), 2)]
    cb = [int(b[i:i + 2], 16) for i in range(1, len(b), 2)]
    return "#" + "".join("%02x" % round(x + (y - x) * f) for x, y in zip(ca, cb))


def fade(start, end, curve, a, b):
    """Keyframes from a at tick start to b at tick end along the curve"""
    frames = []
    for tick in range(start, end, STEP):
        frames.append({"ticks": tick % PERIOD, "value": mix(a, b, bezier(curve, (tick - start) / (end - start)))})
    return frames


def track(day, night, modifier):
    keyframes = [{"ticks": 0, "value": day}]
    keyframes += fade(DUSK, NIGHT, DUSK_CURVE, day, night)
    keyframes.append({"ticks": NIGHT, "value": night})
    keyframes += fade(DAWN, PERIOD, DAWN_CURVE, night, day)
    out = {"keyframes": keyframes}
    if modifier:
        out["modifier"] = modifier
    return out


def turn(at_noon, after_noon):
    return {"ease": TURN_EASE, "keyframes": [{"ticks": NOON, "value": at_noon}, {"ticks": NOON, "value": after_noon}]}


def night_curve():
    """The function keeping the fades' ticks and how dark each tick of them is"""
    dusk = [round(255 * bezier(DUSK_CURVE, i / (NIGHT - DUSK))) for i in range(NIGHT - DUSK)]
    dawn = [round(255 * (1 - bezier(DAWN_CURVE, i / (PERIOD - DAWN)))) for i in range(PERIOD - DAWN)]
    lines = [
        "# Written by 'utils/generate_day_timeline.py', which writes the day these",
        "#  follow: the ticks into the day dusk starts, night falls and dawn starts,",
        "#  and how dark it is, 0 to 255, at each tick of dusk and of dawn",
        "",
        "scoreboard players set $Dusk dr_const %d" % DUSK,
        "scoreboard players set $Night dr_const %d" % NIGHT,
        "scoreboard players set $Dawn dr_const %d" % DAWN,
        "data modify storage derailed:light dusk set value [%s]" % ",".join(map(str, dusk)),
        "data modify storage derailed:light dawn set value [%s]" % ",".join(map(str, dawn)),
    ]
    CURVE_OUT.write_text("\n".join(lines) + "\n", newline="\r\n")
    print("wrote %s" % CURVE_OUT.relative_to(ROOT).as_posix())


def main():
    timeline = {
        "clock": "derailed:game",
        "period_ticks": PERIOD,
        "time_markers": {
            "derailed:day": {"show_in_commands": True, "ticks": 0},
            "derailed:dusk": {"show_in_commands": True, "ticks": DUSK},
            "derailed:night": {"show_in_commands": True, "ticks": NIGHT},
            "derailed:dawn": {"show_in_commands": True, "ticks": DAWN},
        },
        "tracks": {name: track(*spec) for name, spec in FADES.items()},
    }
    timeline["tracks"]["minecraft:visual/sun_angle"] = turn(360.0, 0.0)
    timeline["tracks"]["minecraft:visual/moon_angle"] = turn(540.0, 180.0)
    timeline["tracks"]["minecraft:visual/star_angle"] = turn(360.0, 0.0)
    OUT.write_text(json.dumps(timeline, indent=2) + "\n", newline="\r\n")
    print("wrote %s" % OUT.relative_to(ROOT).as_posix())
    night_curve()


if __name__ == "__main__":
    main()
