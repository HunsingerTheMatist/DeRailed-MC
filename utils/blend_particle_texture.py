"""
Blends two textures' palettes into one, for the particle texture a pair of tree
species has to share.

A block drawn by random blockstate variants takes its particle sprite from the
first variant only - WeightedVariants resolves particleMaterial() once at bake
time, and the interface has no argument for the position or the random pick to
enter through. So both species in a biome break with the first one's particles
unless they are given a texture that suits both.

Each texture is split by hue into a stem palette and a leaf palette, and each
palette is ranked by perceptual lightness. Rank is normalised to 0..1 so two
palettes of different sizes still line up - the lightest of four maps to the
lightest of three, the middle to the middle - and the partner colour is read at
that position, interpolating between neighbours where it falls between them.
The two are then averaged in OkLab, so the result looks halfway to the eye
rather than halfway in storage, which matters when one species is much darker
and less saturated than the other.

The first texture supplies the layout: its alpha is copied through untouched and
only its opaque pixels are recoloured.

Usage:
  py -3 blend_particle_texture.py oak_sapling spruce_sapling oak_spruce_particles
  py -3 blend_particle_texture.py derailed:foo minecraft:bar out --dry-run

A bare name means minecraft:block/<name>, read out of the client jar. Prefix
with `derailed:` to read from the resource pack instead. Output always lands in
resourcepack/assets/derailed/textures/block/<name>.png.
"""
import argparse
import colorsys
import math
import sys
import zipfile
from pathlib import Path

import _png

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # repo root (one level up from utils/)
RESOURCEPACK = ROOT / "resourcepack" / "assets"
OUTPUT_DIR = RESOURCEPACK / "derailed" / "textures" / "block"

DEFAULT_JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.2" / "26.2.jar"

# Hue in degrees. Everything else in a sapling is foliage
STEM_HUE_MAX = 60.0


def srgb_to_linear(value):
    value /= 255.0
    return value / 12.92 if value <= 0.04045 else ((value + 0.055) / 1.055) ** 2.4


def linear_to_srgb(value):
    value = value * 12.92 if value <= 0.0031308 else 1.055 * value ** (1 / 2.4) - 0.055
    return round(255 * min(1.0, max(0.0, value)))


def _cbrt(value):
    """Cube root that keeps the sign, since the LMS terms can go slightly
    negative for colours near the edge of the gamut"""
    return math.copysign(abs(value) ** (1 / 3), value)


def rgb_to_oklab(colour):
    red, green, blue = (srgb_to_linear(c) for c in colour[:3])
    long_ = _cbrt(0.4122214708 * red + 0.5363325363 * green + 0.0514459929 * blue)
    medium = _cbrt(0.2119034982 * red + 0.6806995451 * green + 0.1073969566 * blue)
    short = _cbrt(0.0883024619 * red + 0.2817188376 * green + 0.6299787005 * blue)
    return (0.2104542553 * long_ + 0.7936177850 * medium - 0.0040720468 * short,
            1.9779984951 * long_ - 2.4285922050 * medium + 0.4505937099 * short,
            0.0259040371 * long_ + 0.7827717662 * medium - 0.8086757660 * short)


def oklab_to_rgb(lab):
    lightness, a_axis, b_axis = lab
    long_ = (lightness + 0.3963377774 * a_axis + 0.2158037573 * b_axis) ** 3
    medium = (lightness - 0.1055613458 * a_axis - 0.0638541728 * b_axis) ** 3
    short = (lightness - 0.0894841775 * a_axis - 1.2914855480 * b_axis) ** 3
    return (linear_to_srgb(4.0767416621 * long_ - 3.3077115913 * medium + 0.2309699292 * short),
            linear_to_srgb(-1.2684380046 * long_ + 2.6097574011 * medium - 0.3413193965 * short),
            linear_to_srgb(-0.0041960863 * long_ - 0.7034186147 * medium + 1.7076147010 * short))


def mix_oklab(first, second, weight=0.5):
    """The colour `weight` of the way from `first` to `second`, perceptually"""
    a, b = rgb_to_oklab(first), rgb_to_oklab(second)
    return oklab_to_rgb(tuple(x + (y - x) * weight for x, y in zip(a, b)))


def split_palettes(pixels):
    """Groups the opaque colours into stems and leaves, each ranked from
    darkest to lightest"""
    groups = {"stem": set(), "leaf": set()}
    for red, green, blue, alpha in pixels:
        if alpha == 0:
            continue
        hue = colorsys.rgb_to_hls(red / 255, green / 255, blue / 255)[0] * 360
        groups["stem" if hue < STEM_HUE_MAX else "leaf"].add((red, green, blue))
    return {name: sorted(colours, key=lambda c: rgb_to_oklab(c)[0])
            for name, colours in groups.items()}


def sample_palette(palette, position):
    """Reads a ranked palette at a fractional position from 0 to 1, mixing the
    two neighbours when it lands between entries"""
    if len(palette) == 1:
        return palette[0]
    exact = position * (len(palette) - 1)
    low = min(int(math.floor(exact)), len(palette) - 2)
    return mix_oklab(palette[low], palette[low + 1], exact - low)


def build_mapping(source, partner):
    """Maps each of the source's colours to its blend with the partner's colour
    at the same proportional rank"""
    mapping = {}
    for name, palette in source.items():
        other = partner.get(name)
        if not other:
            continue
        for index, colour in enumerate(palette):
            position = index / (len(palette) - 1) if len(palette) > 1 else 0.0
            mapping[colour] = (mix_oklab(colour, sample_palette(other, position)), position)
    return mapping


def load_texture(reference, jar):
    """Reads a texture named `minecraft:<name>` (from the client jar) or
    `derailed:<name>` (from the resource pack)"""
    namespace, _, name = reference.rpartition(":")
    namespace = namespace or "minecraft"
    if namespace == "minecraft":
        if not jar.is_file():
            raise SystemExit("error: client jar not found at %s (pass --jar)" % jar)
        with zipfile.ZipFile(jar) as archive:
            path = "assets/minecraft/textures/block/%s.png" % name
            if path not in archive.namelist():
                raise SystemExit("error: %s is not in %s" % (path, jar.name))
            return _png.read(archive.read(path))
    path = RESOURCEPACK / namespace / "textures" / "block" / (name + ".png")
    if not path.is_file():
        raise SystemExit("error: %s not found" % path)
    return _png.read(path.read_bytes())


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("source", help="texture supplying the layout and alpha")
    parser.add_argument("partner", help="texture supplying the colours to blend towards")
    parser.add_argument("output", help="name to write under derailed/textures/block/")
    parser.add_argument("--jar", type=Path, default=DEFAULT_JAR, help="client jar to read vanilla textures from")
    parser.add_argument("--dry-run", action="store_true", help="print the mapping without writing")
    args = parser.parse_args()

    width, height, pixels = load_texture(args.source, args.jar)
    _, _, partner_pixels = load_texture(args.partner, args.jar)

    source = split_palettes(pixels)
    partner = split_palettes(partner_pixels)
    for name in ("stem", "leaf"):
        if not source[name]:
            print("warning: %s has no %s colours" % (args.source, name))
        if not partner[name]:
            print("warning: %s has no %s colours, so its %s shades are left alone"
                  % (args.partner, name, args.source))

    mapping = build_mapping(source, partner)

    print("%-6s %-9s %-9s %-9s %s" % ("group", "source", "partner", "blended", "rank"))
    for name, palette in source.items():
        for index, colour in enumerate(palette):
            if colour not in mapping:
                continue
            blended, position = mapping[colour]
            print("%-6s #%02X%02X%02X   #%02X%02X%02X   #%02X%02X%02X   %.2f"
                  % ((name,) + colour + sample_palette(partner[name], position) + blended + (position,)))

    if args.dry_run:
        return 0

    out = [(mapping[(r, g, b)][0] + (a,) if a and (r, g, b) in mapping else (r, g, b, a))
           for r, g, b, a in pixels]
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    target = OUTPUT_DIR / (args.output + ".png")
    _png.write(target, width, height, out)
    print("\nwrote %s (%dx%d)" % (target.relative_to(ROOT).as_posix(), width, height))
    return 0


if __name__ == "__main__":
    sys.exit(main())
