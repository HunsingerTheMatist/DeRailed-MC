"""Shared helpers for reading pack.mcmeta and resolving the target MC version.
The MC-version lookup is offline — backed by pack_format_versions.json (refresh
that file via fetch_pack_format_versions.py, which is the only script in this
project that hits the network for version data).
"""
import json
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
VERSIONS_FILE = SCRIPT_DIR / "pack_format_versions.json"


def read_pack_max_format(root: Path) -> tuple[int, int]:
    """Reads pack.mcmeta's `pack.max_format`. Accepts either an int (legacy single-
    component format) or a list `[major, minor]` (compound format introduced in
    pack format 100+). Returns `(major, minor)` with minor defaulting to 0."""
    pack_mcmeta = root / "pack.mcmeta"
    if not pack_mcmeta.is_file():
        sys.exit(f"pack.mcmeta not found at {pack_mcmeta}")
    data = json.loads(pack_mcmeta.read_text(encoding="utf-8"))
    fmt = data["pack"]["max_format"]
    if isinstance(fmt, list):
        return int(fmt[0]), int(fmt[1]) if len(fmt) > 1 else 0
    return int(fmt), 0


def resolve_target_mc_version(root: Path) -> str:
    """Returns the MC release id (e.g. '26.1.2') matching pack.mcmeta's max_format.
    Lookup is offline against pack_format_versions.json. Same-major matching is
    fuzzy along the minor axis: prefer the lowest minor >= ours (forward), fall
    back to the highest minor < ours if no forward entry exists. Errors out if
    the lookup file is missing or no entry with the same major exists — in
    either case, run fetch_pack_format_versions.py to refresh."""
    major, minor = read_pack_max_format(root)
    if not VERSIONS_FILE.is_file():
        sys.exit(f"{VERSIONS_FILE.name} not found at {VERSIONS_FILE}. "
                 f"Run fetch_pack_format_versions.py first.")
    versions = json.loads(VERSIONS_FILE.read_text(encoding="utf-8"))

    same_major: dict[int, str] = {}
    for key, value in versions.items():
        k_major, k_minor = (int(p) for p in key.split("."))
        if k_major == major:
            same_major[k_minor] = value

    if not same_major:
        sys.exit(f"No entry with pack format major {major} in {VERSIONS_FILE.name}. "
                 f"pack.mcmeta's max_format targets a major outside the offline "
                 f"index — run fetch_pack_format_versions.py to refresh.")

    forward = [m for m in same_major if m >= minor]
    if forward:
        return same_major[min(forward)]
    return same_major[max(same_major)]