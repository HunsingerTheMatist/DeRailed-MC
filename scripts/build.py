"""
Builds the distributable DeRailed zip into builds/. Output filename is
DeRailed-v<datapack version>-mc<MC version>-build<build #>.zip, where:
  - datapack version is parsed from load.mcfunction's `Version` setter and
    stripped to its first contiguous numeric+dot run (e.g. 'beta 0.9' → '0.9').
  - MC version is resolved offline via _pack_meta.resolve_target_mc_version
    (refresh the lookup with fetch_pack_format_versions.py) and trimmed to
    its major.minor prefix (e.g. '26.1.2' → '26.1').
  - build # is tracked in build_info.json: increments on each run while the
    datapack version is unchanged, resets to 1 when the version changes.
"""
import argparse
import json
import re
import sys
from pathlib import Path
from zipfile import ZipFile

from _pack_meta import resolve_target_mc_version

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent  # datapack root (one level up from scripts/)
BUILD_INFO_FILE = SCRIPT_DIR / "build_info.json"
LOAD_MCFUNCTION = ROOT / "data" / "derailed" / "function" / "load.mcfunction"
BUILDS_DIR = ROOT / "builds"

# Files and folders (relative to ROOT) to include in the zip. Folders are walked
#  recursively. Anything not listed here is excluded from the build.
INCLUDE = ["pack.mcmeta", "pack.png", "README.md", "data"]


def parse_datapack_version() -> str:
    """Reads load.mcfunction's `data modify storage derailed:data Version set
    value "..."` line and strips the value to its first contiguous numeric+dot
    run (e.g. 'beta 0.9' → '0.9'). Errors out if the setter line or a numeric
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
        sys.exit(f"Datapack version {raw!r} contains no numeric component.")
    return numeric.group(0)


def short_mc_version(full: str) -> str:
    """Trims an MC release id like '26.1.2' or '26.2-snapshot-6' down to its
    major.minor prefix (e.g. '26.1', '26.2')."""
    m = re.match(r'^([0-9]+\.[0-9]+)', full)
    if not m:
        sys.exit(f"MC version {full!r} doesn't start with major.minor.")
    return m.group(1)


def update_build_info(dp_version: str) -> int:
    """Reads build_info.json (creating it on first run), bumps the build number
    if the datapack version is unchanged or resets to 1 if it changed, writes
    the file back, and returns the new build number."""
    if BUILD_INFO_FILE.is_file():
        info = json.loads(BUILD_INFO_FILE.read_text(encoding="utf-8"))
    else:
        info = {}

    if info.get("latest_version") == dp_version:
        info["build_number"] = int(info.get("build_number", 0)) + 1
    else:
        info["latest_version"] = dp_version
        info["build_number"] = 1

    BUILD_INFO_FILE.write_text(json.dumps(info, indent=2) + "\n", encoding="utf-8")
    return info["build_number"]


def main() -> None:
    parser = argparse.ArgumentParser(description="Build the distributable DeRailed zip.")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Print every file as it's added to the zip.")
    args = parser.parse_args()

    dp_version = parse_datapack_version()
    mc_version = short_mc_version(resolve_target_mc_version(ROOT))
    build = update_build_info(dp_version)

    BUILDS_DIR.mkdir(exist_ok=True)
    zip_name = f"DeRailed-v{dp_version}-mc{mc_version}-build{build}.zip"
    zip_path = BUILDS_DIR / zip_name

    if zip_path.exists():
        zip_path.unlink()

    written = 0
    with ZipFile(zip_path, "w") as zf:
        for entry in INCLUDE:
            src = ROOT / entry
            if not src.exists():
                sys.exit(f"Required entry missing from datapack root: {entry}")
            if src.is_file():
                zf.write(src, entry)
                if args.verbose:
                    print(entry)
                written += 1
                continue
            for sub in sorted(src.rglob("*")):
                if sub.is_file():
                    rel = sub.relative_to(ROOT).as_posix()
                    zf.write(sub, rel)
                    if args.verbose:
                        print(rel)
                    written += 1

    print(f"Wrote builds/{zip_name} ({written} files)")


if __name__ == "__main__":
    main()