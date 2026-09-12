"""
Pulls every client asset a block draws with out of the vanilla jar, following
the references rather than guessing at filenames.

Starting from a block id it takes the blockstate, every model that blockstate
names, every model reached by walking `parent` upwards, every texture those
models resolve, any `.mcmeta` animation beside a texture, and the item
definition with its own models. Files land under the output directory at the
same path they hold inside the jar, so the copy reads like a resource pack and
can be dropped into one.

Usage:
  py -3 extract_block_assets.py crimson_stem warped_stem --out notes/huge_fungus
  py -3 extract_block_assets.py shroomlight --out notes/x --dry-run

A bare name means minecraft:<name>. Pass --jar to read a different client jar.
"""
import argparse
import json
import sys
import zipfile
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.2" / "26.2.jar"


def resolve(reference, kind):
    """Turns 'minecraft:block/foo' into its path inside the jar"""
    namespace, _, path = reference.rpartition(":")
    namespace = namespace or "minecraft"
    suffix = "png" if kind == "textures" else "json"
    return "assets/%s/%s/%s.%s" % (namespace, kind, path, suffix)


def model_refs(model):
    """Every model this one points at: its parent, plus anything a nested
    `model` field names, which is how item definitions carry theirs"""
    found = []
    if isinstance(model, dict):
        for key, value in model.items():
            if key in ("parent", "model") and isinstance(value, str):
                found.append(value)
            else:
                found += model_refs(value)
    elif isinstance(model, list):
        for item in model:
            found += model_refs(item)
    return found


def texture_refs(model):
    """Texture names a model resolves, skipping '#slot' indirections since those
    are answered by the model's own textures map or by a child's"""
    found = []
    for value in model.get("textures", {}).values():
        if isinstance(value, str) and not value.startswith("#"):
            found.append(value)
    for element in model.get("elements", []):
        for face in element.get("faces", {}).values():
            name = face.get("texture", "")
            if name and not name.startswith("#"):
                found.append(name)
    return found


def blockstate_models(definition):
    """Every model named by a blockstate, across variants and multipart"""
    found = []
    for entry in definition.get("variants", {}).values():
        found += model_refs(entry)
    for part in definition.get("multipart", []):
        found += model_refs(part.get("apply"))
    return found


def collect(archive, blocks, warn):
    """Walks from each block id out to every file it needs, returning the set
    of jar paths"""
    names = set(archive.namelist())
    wanted = set()
    pending_models = []

    for block in blocks:
        namespace, _, name = block.rpartition(":")
        namespace = namespace or "minecraft"

        state_path = "assets/%s/blockstates/%s.json" % (namespace, name)
        if state_path in names:
            wanted.add(state_path)
            pending_models += blockstate_models(json.loads(archive.read(state_path)))
        else:
            warn("%s has no blockstate in the jar" % block)

        # The item definition is a separate file from the block's models, and
        #  names its own model tree
        item_path = "assets/%s/items/%s.json" % (namespace, name)
        if item_path in names:
            wanted.add(item_path)
            pending_models += model_refs(json.loads(archive.read(item_path)))

    seen_models = set()
    while pending_models:
        reference = pending_models.pop()
        # builtin/generated and builtin/entity name renderers in code, not files
        if reference.split(":")[-1].startswith("builtin/"):
            continue
        path = resolve(reference, "models")
        if path in seen_models:
            continue
        seen_models.add(path)
        if path not in names:
            warn("model %s is missing from the jar" % reference)
            continue
        wanted.add(path)
        model = json.loads(archive.read(path))
        pending_models += model_refs(model)
        for texture in texture_refs(model):
            texture_path = resolve(texture, "textures")
            if texture_path in names:
                wanted.add(texture_path)
                if texture_path + ".mcmeta" in names:
                    wanted.add(texture_path + ".mcmeta")
            else:
                warn("texture %s is missing from the jar" % texture)
    return wanted


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("blocks", nargs="+", help="block ids, bare names meaning minecraft:")
    parser.add_argument("--out", required=True, help="directory to extract into, relative to utils/")
    parser.add_argument("--jar", type=Path, default=DEFAULT_JAR)
    parser.add_argument("--dry-run", action="store_true", help="list the files without writing")
    args = parser.parse_args()

    if not args.jar.is_file():
        raise SystemExit("error: client jar not found at %s (pass --jar)" % args.jar)

    warnings = []
    with zipfile.ZipFile(args.jar) as archive:
        wanted = collect(archive, args.blocks, warnings.append)

        out_dir = (SCRIPT_DIR / args.out).resolve()
        by_kind = {}
        for path in sorted(wanted):
            by_kind.setdefault(path.split("/")[2], []).append(path)
            if args.dry_run:
                continue
            target = out_dir / path
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(archive.read(path))

    for kind, paths in sorted(by_kind.items()):
        print("%s (%d)" % (kind, len(paths)))
        for path in paths:
            print("   %s" % path.split("/", 3)[3])

    print()
    print("%s %d files %s %s" % ("would extract" if args.dry_run else "extracted",
                                 len(wanted), "from" if args.dry_run else "to",
                                 args.jar.name if args.dry_run else out_dir))
    for warning in warnings:
        print("warning: %s" % warning)
    return 0


if __name__ == "__main__":
    sys.exit(main())
