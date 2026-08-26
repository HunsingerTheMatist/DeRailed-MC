"""
Builds the distributable DeRailed zips into builds/. One zip per pack:
  DeRailed-datapack-v<version>-mc<MC version>-build<n>.zip
  DeRailed-resourcepack-v<version>-mc<MC version>-build<n>.zip
where:
  - version is parsed from load.mcfunction's `Version` setter and stripped to
    its first contiguous numeric+dot run (e.g. 'beta 0.9' -> '0.9'). Both packs
    share it; they are versioned and shipped together.
  - MC version is resolved offline from the DATA PACK's pack.mcmeta via
    _pack_meta.resolve_target_mc_version (refresh the lookup with
    fetch_pack_format_versions.py) and trimmed to its major.minor prefix.
  - build # is tracked in build_info.json: increments on each run while the
    version is unchanged, resets to 1 when the version changes. One build
    number covers both zips.
"""
import argparse
import json
import re
import sys
from pathlib import Path
from zipfile import ZipFile

from _pack_meta import resolve_target_mc_version

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # repo root (one level up from utils/)
BUILD_INFO_FILE = SCRIPT_DIR / "build_info.json"
BUILDS_DIR = ROOT / "builds"

DATAPACK_DIR = ROOT / "datapack"
RESOURCEPACK_DIR = ROOT / "resourcepack"
LOAD_MCFUNCTION = DATAPACK_DIR / "data" / "derailed" / "function" / "load.mcfunction"

# Per-pack contents, relative to that pack's own directory. Folders are walked
#  recursively. Anything not listed here is excluded from the build.
PACKS = {
    "datapack": {"dir": DATAPACK_DIR, "include": ["pack.mcmeta", "pack.png", "data"]},
    "resourcepack": {"dir": RESOURCEPACK_DIR, "include": ["pack.mcmeta", "pack.png", "assets"]},
}

# Repo-root files copied into the top level of every zip.
SHARED_ROOT_FILES = ["README.md"]


def parse_version() -> str:
    """Reads load.mcfunction's `data modify storage derailed:data Version set
    value "..."` line and strips the value to its first contiguous numeric+dot
    run (e.g. 'beta 0.9' -> '0.9'). Errors out if the setter line or a numeric
    component is missing."""
    if not LOAD_MCFUNCTION.is_file():
        sys.exit(f"load.mcfunction not found at {LOAD_MCFUNCTION}")
    text = LOAD_MCFUNCTION.read_text(encoding="utf-8")
    setter = re.search(r'storage derailed:data Version set value "([^"]*)"', text)
    if not setter:
        sys.exit("Could not find the Version setter line in load.mcfunction.")
    raw = setter.group(1)
    numeric = re.search(r'[0-9]+(?:\.[0-9]+)*', raw)
    if not numeric:
        sys.exit(f"Version {raw!r} contains no numeric component.")
    return numeric.group(0)


def short_mc_version(full: str) -> str:
    """Trims an MC release id like '26.2.1' or '26.2-snapshot-6' down to its
    major.minor prefix (e.g. '26.2')."""
    m = re.match(r'^([0-9]+\.[0-9]+)', full)
    if not m:
        sys.exit(f"MC version {full!r} doesn't start with major.minor.")
    return m.group(1)


def update_build_info(version: str) -> int:
    """Reads build_info.json (creating it on first run), bumps the build number
    if the version is unchanged or resets to 1 if it changed, writes the file
    back, and returns the new build number."""
    if BUILD_INFO_FILE.is_file():
        info = json.loads(BUILD_INFO_FILE.read_text(encoding="utf-8"))
    else:
        info = {}

    if info.get("latest_version") == version:
        info["build_number"] = int(info.get("build_number", 0)) + 1
    else:
        info["latest_version"] = version
        info["build_number"] = 1

    BUILD_INFO_FILE.write_text(json.dumps(info, indent=2) + "\n", encoding="utf-8")
    return info["build_number"]


def build_pack(name: str, spec: dict, zip_path: Path, verbose: bool) -> int:
    """Zips one pack: its own `include` entries relative to its directory, plus
    the shared repo-root files at the top level. Returns the file count."""
    if zip_path.exists():
        zip_path.unlink()

    written = 0
    with ZipFile(zip_path, "w") as zf:
        for entry in spec["include"]:
            src = spec["dir"] / entry
            if not src.exists():
                sys.exit(f"Required entry missing from {name}: {entry}")
            if src.is_file():
                zf.write(src, entry)
                if verbose:
                    print(f"  {entry}")
                written += 1
                continue
            for sub in sorted(src.rglob("*")):
                # .gitkeep only exists to keep empty dirs in git; not pack content.
                if sub.is_file() and sub.name != ".gitkeep":
                    rel = sub.relative_to(spec["dir"]).as_posix()
                    zf.write(sub, rel)
                    if verbose:
                        print(f"  {rel}")
                    written += 1

        for entry in SHARED_ROOT_FILES:
            src = ROOT / entry
            if not src.is_file():
                sys.exit(f"Required repo-root file missing: {entry}")
            zf.write(src, entry)
            if verbose:
                print(f"  {entry}")
            written += 1

    return written


def main() -> None:
    parser = argparse.ArgumentParser(description="Build the distributable DeRailed zips.")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Print every file as it's added to a zip.")
    parser.add_argument("--only", choices=sorted(PACKS),
                        help="Build just one pack instead of both.")
    args = parser.parse_args()

    version = parse_version()
    # Resolve the MC version from the DATA PACK only. Data pack and resource pack
    #  format numbers are independently numbered and collide (e.g. 88 means
    #  1.21.10 as a data pack format but 26.2 as a resource pack format), and
    #  pack_format_versions.json indexes data pack formats. Never point the
    #  resolver at resourcepack/pack.mcmeta.
    mc_version = short_mc_version(resolve_target_mc_version(DATAPACK_DIR))
    build = update_build_info(version)

    BUILDS_DIR.mkdir(exist_ok=True)
    selected = [args.only] if args.only else sorted(PACKS)

    for name in selected:
        spec = PACKS[name]
        content_dirs = [d for d in spec["include"] if (spec["dir"] / d).is_dir()]
        if not any(any(p.is_file() and p.name != ".gitkeep"
                       for p in (spec["dir"] / d).rglob("*")) for d in content_dirs):
            print(f"Warning: {name} has no content yet - building it anyway.")

        zip_name = f"DeRailed-{name}-v{version}-mc{mc_version}-build{build}.zip"
        if args.verbose:
            print(zip_name)
        written = build_pack(name, spec, BUILDS_DIR / zip_name, args.verbose)
        print(f"Wrote builds/{zip_name} ({written} files)")


if __name__ == "__main__":
    main()
