"""Writes a zombie climbing out of the ground: one item model for each tick of
its animation, and the item that steps through them, for an item display to
show tick by tick.

The animation lives in a Blockbench project, 'zombie_emerge.bbmodel', a Generic
Model with the zombie's bones, boxes and texture and an animation called
'emerge', to be opened, played and changed in Blockbench and saved. This script
reads it and bakes it: each bone keyframe blended as Blockbench blends it, so
the frames are what Blockbench plays, Catmull-Rom, Bezier, linear or held, and
each bone standing as the game stands a model part, moved to its pivot then
turned about z, y and x.

Blockbench shows the zombie upright with its feet at 0, as the game draws a mob,
and its bone keyframes mean what the game's keyframes mean: a model part is
flipped by a half turn about z to be drawn, and Blockbench turns and moves a
bone the other way along x and y to match, so its numbers are the game's as
they are. The project's boxes are flipped back into the model part's pixels to
bake them.

'--from-warden' writes the project afresh from the warden's own emerge
animation, the keyframes of WardenAnimation.WARDEN_EMERGE from the 26.3 client
in 'warden_emerge.json', played on a zombie built the way the warden is: its
body on its hips and its head and arms riding the body, its legs on its feet.
The moves are scaled by SCALE, the zombie's height against the warden's, and
only the parts MOVES_FROM names move, so the zombie's arms, head and legs stay
joined to its body; every part turns. Its shorter arms are made up for through
HANDS_DOWN, the body let down until its hands reach the ground, and from STAND
it stands where it ends, legs straight and still, bent over with its hands
down and its head tucked until RISE, when it straightens its body and lifts its
head together, raising its arms to a zombie's, ZOMBIE_ARMS: the stand-up is
written as a keyframe every STEP seconds, the body overshooting upright and
settling and swaying, the head lagging, nodding and tilting, and the arms
rising one after the other, as the settings beside STEP say. It will not write over a project that is already
there without '--force'.

Each frame is a block model of the zombie as it stands that tick, one box a
part, each turned as its part is. It is drawn at half size, MODEL_SCALE, and
the display shows it at twice that, so even underground at the start or
reaching up its parts stay inside the -16 to 32 a model allows; its feet stand
at the model's middle, so the display stands where the zombie's feet will. It
faces as a zombie with no turn of its own does: an item display turns its model
half a turn, as the game turns a mob half a turn to face its way, so the display
faces the way the zombie will.

Run from the repository root: py -3 utils/generate_zombie_emerge.py
"""
import base64
import json
import math
import sys
import uuid
import zipfile
from pathlib import Path

import _png

SCRIPT_DIR = Path(__file__).resolve().parent
ROOT = SCRIPT_DIR.parent
ASSETS = ROOT / "resourcepack" / "assets" / "derailed"
JAR = Path.home() / "AppData" / "Roaming" / ".minecraft" / "versions" / "26.3" / "26.3.jar"
KEYFRAMES = SCRIPT_DIR / "warden_emerge.json"
PROJECT = SCRIPT_DIR / "zombie_emerge.bbmodel"

NAME = "zombie_emerge"
ANIMATION = "emerge"
TICKS_PER_SECOND = 20
SCALE = 32 / 50
MODEL_SCALE = 0.5
TEXTURE_SIZE = 64
LIMITS = (-16, 32)
GROUND = 24

# The zombie's parts the warden's way, for '--from-warden': each with its
#  parent, its pivot from the parent's, and its boxes as (texture u, texture v,
#  mirrored, from, size, grown), in model pixels with y down as a model part
#  has them
WARDEN_RIG = {
    "bone": (None, (0, 24, 0), []),
    "body": ("bone", (0, -12, 0), [(16, 16, False, (-4, -12, -2), (8, 12, 4), 0)]),
    "head": ("body", (0, -12, 0), [(0, 0, False, (-4, -8, -4), (8, 8, 8), 0),
                                   (32, 0, False, (-4, -8, -4), (8, 8, 8), 0.5)]),
    "right_arm": ("body", (-5, -10, 0), [(40, 16, False, (-3, -2, -2), (4, 12, 4), 0)]),
    "left_arm": ("body", (5, -10, 0), [(40, 16, True, (-1, -2, -2), (4, 12, 4), 0)]),
    "right_leg": ("bone", (-1.9, -12, 0), [(0, 16, False, (-2, 0, -2), (4, 12, 4), 0)]),
    "left_leg": ("bone", (1.9, -12, 0), [(0, 16, True, (-2, 0, -2), (4, 12, 4), 0)]),
}

# Where each part's moves come from, for '--from-warden': the warden moves its
#  arms, head and legs about on their own, which its long body hides but a
#  zombie's would show as the parts parting from it, so a zombie's arms and head
#  keep their places on its body and its legs move as its body does, staying at
#  its hips; each part still turns as the warden's does
MOVES_FROM = {
    "body": "body",
    "head": None,
    "right_arm": None,
    "left_arm": None,
    "right_leg": "body",
    "left_leg": "body",
}

# The warden's legs ride its body up and back as it stands, which a zombie's
#  stiff legs, with no knee to bend, show as gliding: from STAND on, the body
#  stands where it ends, its hips over its feet, so the legs stand straight and
#  still on the ground, and until it straightens to stand it bends forward BEND
#  degrees with its arms straight down, its hands on the ground
STAND = 5.0
BEND = 95.0

# Once standing it holds bent over, head down, until RISE, then straightens its
#  body and lifts its head together, so the two read as one movement; at STAND
#  it holds not at all
RISE = STAND

# As it straightens its arms come up from hanging to the way a zombie holds them
#  when it is not after anything, as the game poses it: forward, a little short
#  of level, turned a little in, in degrees for the right and left arm
ZOMBIE_ARMS = {"right_arm": [-80.0, -5.73, 0.0], "left_arm": [-80.0, 5.73, 0.0]}

# The stand-up, from RISE to the end, written as a keyframe every STEP seconds
#  from these, each part eased in and out:
#  STRAIGHTEN seconds the body takes to straighten, the head and arms done
#             SETTLE after it, where the animation ends
#  OVERSHOOT  degrees the body tips back past upright, settling back over the
#             last SETTLE seconds
#  SWAY       degrees the body rolls to one side and then the other as it rises
#  HEAD_LAG   seconds the head starts, and ends, lifting after the body
#  NOD        degrees the head nods forward as the body settles
#  TILT       degrees the head tilts to one side partway up
#  ARM_LAG    seconds each arm starts rising after the body, the right first
STEP = 0.1
STRAIGHTEN = 1.0
OVERSHOOT = 0.0
SETTLE = 0.25
SWAY = 3.0
HEAD_LAG = 0.1
NOD = 0.0
TILT = 6.0
ARM_LAG = {"right_arm": 0.12, "left_arm": 0.22}


def smoothstep(u):
    """Eased from 0 to 1: slow out, fast through the middle, slow in"""
    u = max(0.0, min(1.0, u))
    return u * u * (3 - 2 * u)

# The warden's arms are longer than a zombie's, so where it pulls itself up by
#  the ground the zombie's hands would close on air: through HANDS_DOWN, until
#  it stands, each of the body's moves is let down as far as its lower hand is
#  off the ground then
HANDS_DOWN = (3.1, STAND)


def point(placed, part, local):
    """A point of a part, given in the part's own pixels, where the pose puts it
    in the model part's pixels, y down"""
    turn, pos = placed[part]
    return [a + b for a, b in zip(pos, mat_vec(turn, local))]


# --- small 3x3 matrix helpers ---

def mat_mul(a, b):
    return [[sum(a[i][k] * b[k][j] for k in range(3)) for j in range(3)] for i in range(3)]


def mat_vec(m, v):
    return [sum(m[i][k] * v[k] for k in range(3)) for i in range(3)]


def rot_x(a):
    c, s = math.cos(a), math.sin(a)
    return [[1, 0, 0], [0, c, -s], [0, s, c]]


def rot_y(a):
    c, s = math.cos(a), math.sin(a)
    return [[c, 0, s], [0, 1, 0], [-s, 0, c]]


def rot_z(a):
    c, s = math.cos(a), math.sin(a)
    return [[c, -s, 0], [s, c, 0], [0, 0, 1]]


def zyx(x, y, z):
    """Turned about z, then y, then x, as a model part and a model element turn"""
    return mat_mul(rot_z(z), mat_mul(rot_y(y), rot_x(x)))


def zyx_angles(m):
    """The x, y and z angles, in degrees, that 'zyx' turns by to give m"""
    y = math.asin(max(-1.0, min(1.0, -m[2][0])))
    if abs(math.cos(y)) > 1e-6:
        x = math.atan2(m[2][1], m[2][2])
        z = math.atan2(m[1][0], m[0][0])
    else:
        x = math.atan2(-m[1][2], m[1][1])
        z = 0.0
    return [math.degrees(x), math.degrees(y), math.degrees(z)]


# The model part flipped as the game flips a mob, which is a half turn about z
FLIP = [[-1, 0, 0], [0, -1, 0], [0, 0, 1]]


def to_upright(p):
    """A model part's pixel as Blockbench and the world have it: upright, feet
    at 0"""
    return [-p[0], GROUND - p[1], p[2]]


# --- the animation ---

def catmullrom(a, p0, p1, p2, p3):
    return 0.5 * (2 * p1 + (p2 - p0) * a + (2 * p0 - 5 * p1 + 4 * p2 - p3) * a * a
                  + (3 * p1 - p0 - 3 * p2 + p3) * a * a * a)


def value(k, axis):
    """A keyframe's value along an axis as the game takes it: turns to radians,
    and a move's y the other way, as a model part's y runs down"""
    v = k["v"][axis]
    if k["target"] == "ROTATION":
        return math.radians(v)
    return -v if axis == 1 else v


def handle(k, side, axis):
    """A keyframe's Bezier handle on one side along one axis: how far on in
    time and how much more in value, its value taken as 'value' takes it"""
    times = k.get("handles", {}).get(side + "_t", [-0.1] * 3 if side == "left" else [0.1] * 3)
    values = k.get("handles", {}).get(side + "_v", [0.0] * 3)
    v = values[axis]
    if k["target"] == "ROTATION":
        v = math.radians(v)
    elif axis == 1:
        v = -v
    return times[axis], v


def bezier(before, after, axis, seconds):
    """Blockbench's Bezier between two keyframes: a curve through time and value
    from the one to the other, pulled by the first's right handle and the
    second's left, each held inside the gap between them"""
    gap = after["t"] - before["t"]
    t0, v0 = before["t"], value(before, axis)
    t3, v3 = after["t"], value(after, axis)
    rt, rv = handle(before, "right", axis)
    lt, lv = handle(after, "left", axis)
    t1, v1 = t0 + max(0.0, min(gap, rt)), v0 + rv
    t2, v2 = t3 + max(-gap, min(0.0, lt)), v3 + lv

    def at(u, a, b, c, d):
        return (1 - u) ** 3 * a + 3 * (1 - u) ** 2 * u * b + 3 * (1 - u) * u * u * c + u ** 3 * d

    low, high = 0.0, 1.0
    for _ in range(50):
        mid = (low + high) / 2
        if at(mid, t0, t1, t2, t3) < seconds:
            low = mid
        else:
            high = mid
    return at((low + high) / 2, v0, v1, v2, v3)


def sample(keys, seconds):
    """A channel at 'seconds', blended as Blockbench blends it, so the baked
    frames are what Blockbench plays: linear where the keyframe before is
    linear and the one after linear or held, Catmull-Rom where either asks for
    it, otherwise Bezier where either asks for it, and held at the keyframe
    before where it asks to be held"""
    first = next((i for i, k in enumerate(keys) if seconds <= k["t"]), len(keys))
    prev = max(0, first - 1)
    nxt = min(len(keys) - 1, prev + 1)
    before, after = keys[prev], keys[nxt]
    span = after["t"] - before["t"]
    alpha = max(0.0, min(1.0, (seconds - before["t"]) / span)) if nxt != prev else 0.0
    blends = (before["interp"], after["interp"])
    out = []
    for axis in range(3):
        if nxt == prev or seconds <= before["t"]:
            out.append(value(before, axis))
        elif blends[0] == "LINEAR" and blends[1] in ("LINEAR", "STEP"):
            a, b = value(before, axis), value(after, axis)
            out.append(a + (b - a) * alpha)
        elif "CATMULLROM" in blends:
            points = [keys[max(0, prev - 1)], before, after, keys[min(len(keys) - 1, nxt + 1)]]
            out.append(catmullrom(alpha, *(value(k, axis) for k in points)))
        elif "BEZIER" in blends:
            out.append(bezier(before, after, axis, seconds))
        else:
            out.append(value(after if alpha >= 1 else before, axis))
    return out


def pose(rig, channels, seconds):
    """Each part's place: its turn and where its pivot stands, in the model
    part's pixels, y down"""
    offsets = {name: {"POSITION": [0, 0, 0], "ROTATION": [0, 0, 0]} for name in rig}
    for c in channels:
        if c["bone"] in offsets and c["keys"]:
            offsets[c["bone"]][c["target"]] = sample(c["keys"], seconds)

    placed = {}
    for name, (parent, pivot, _, *rest) in rig.items():
        resting = rest[0] if rest else (0, 0, 0)
        pos = [p + o for p, o in zip(pivot, offsets[name]["POSITION"])]
        turn = zyx(*(r + o for r, o in zip(resting, offsets[name]["ROTATION"])))
        if parent is None:
            placed[name] = (turn, pos)
        else:
            parent_turn, parent_pos = placed[parent]
            placed[name] = (mat_mul(parent_turn, turn), [a + b for a, b in zip(parent_pos, mat_vec(parent_turn, pos))])
    return placed


# --- the warden's animation, for '--from-warden' ---

def from_warden():
    """The rig and the channels of the warden's emerge played on a zombie, and
    how long it lasts"""
    data = json.loads(KEYFRAMES.read_text())
    by_bone = {}
    for c in data["channels"]:
        target = c["target"]
        keys = [{"t": k["t"], "target": target, "interp": k["interp"],
                 "v": [x * SCALE for x in k["v"]] if target == "POSITION" else list(k["v"])} for k in c["keys"]]
        by_bone[(c["bone"], target)] = keys
    channels = []
    for name in WARDEN_RIG:
        if name not in MOVES_FROM:
            continue
        if (name, "ROTATION") in by_bone:
            channels.append({"bone": name, "target": "ROTATION", "keys": by_bone[(name, "ROTATION")]})
        source = MOVES_FROM[name]
        if source and (source, "POSITION") in by_bone:
            channels.append({"bone": name, "target": "POSITION",
                             "keys": [dict(k, v=list(k["v"])) for k in by_bone[(source, "POSITION")]]})
    length = data["length"]

    def lower_hand(t):
        placed = pose(WARDEN_RIG, channels, t)
        return max(point(placed, "right_arm", (-1, 10, 0))[1], point(placed, "left_arm", (1, 10, 0))[1])

    moves = [c for c in channels if c["target"] == "POSITION" and MOVES_FROM.get(c["bone"]) == "body"]
    body_moves = next(c for c in moves if c["bone"] == "body")["keys"]
    body_turns = next(c for c in channels if c["bone"] == "body" and c["target"] == "ROTATION")["keys"]
    last = max(k["t"] for k in body_moves)

    # Standing from STAND on: the body's moves, and the legs' with them, held at
    #  where it ends, its hips over its feet
    for c in moves:
        for k in c["keys"]:
            if k["t"] >= STAND:
                k["v"] = list(next(e for e in c["keys"] if e["t"] == last)["v"])

    # The hands put down: each of the body's moves in HANDS_DOWN let down by its
    #  lower hand's height then, and the legs' with it
    drops = {k["t"]: max(0.0, GROUND - lower_hand(k["t"])) for k in body_moves if HANDS_DOWN[0] <= k["t"] < HANDS_DOWN[1]}
    for c in moves:
        for k in c["keys"]:
            k["v"][1] -= drops.get(k["t"], 0.0)

    # Bent down once standing: the body's turn at STAND bent forward BEND
    #  degrees, held still until RISE where RISE is later, so the keyframes
    #  either side do not swing it past it, and none between that and its
    #  straightening at the end
    holding = RISE > STAND
    body_turns[:] = [k for k in body_turns if not STAND < k["t"] < last]
    for k in body_turns:
        if k["t"] == STAND:
            k["v"] = [BEND, 0.0, 0.0]
    if holding:
        body_turns.append({"t": RISE, "target": "ROTATION", "interp": "LINEAR", "v": [BEND, 0.0, 0.0]})
        body_turns.sort(key=lambda k: k["t"])
    for c in moves:
        for k in c["keys"]:
            if k["t"] > STAND:
                k["interp"] = "LINEAR"

    # The head held as it is at STAND until RISE, so it lifts as the body
    #  straightens
    head = next(c for c in channels if c["bone"] == "head" and c["target"] == "ROTATION")
    tucked = next((list(k["v"]) for k in head["keys"] if k["t"] == STAND), None)
    if holding and tucked is not None:
        head["keys"] = sorted([k for k in head["keys"] if not STAND < k["t"] <= RISE] + [
            {"t": RISE, "target": "ROTATION", "interp": "LINEAR", "v": tucked},
        ], key=lambda k: k["t"])

    # The arms hang straight down at STAND, turned against the body's bend, and
    #  come up as it straightens to how a zombie holds them, ZOMBIE_ARMS, by the
    #  end
    for arm in ("right_arm", "left_arm"):
        rotation = next(c for c in channels if c["bone"] == arm and c["target"] == "ROTATION")
        hanging = [{"t": STAND, "target": "ROTATION", "interp": "CATMULLROM", "v": [-BEND, 0.0, 0.0]}]
        if holding:
            hanging.append({"t": RISE, "target": "ROTATION", "interp": "LINEAR", "v": [-BEND, 0.0, 0.0]})
        rotation["keys"] = [k for k in rotation["keys"] if k["t"] < STAND] + hanging + [
            {"t": last, "target": "ROTATION", "interp": "CATMULLROM", "v": list(ZOMBIE_ARMS[arm])},
        ]

    # The stand-up, from RISE to the end, a keyframe every STEP seconds: the
    #  body eased up past upright by OVERSHOOT and settled back over SETTLE,
    #  swaying by SWAY; the head lifting HEAD_LAG after it, nodding by NOD as it
    #  settles and tilting by TILT partway up; each arm rising ARM_LAG after it
    #  to ZOMBIE_ARMS; all of it ending as the zombie stands. Linear between,
    #  Blockbench blending Catmull-Rom over the rest where either keyframe asks
    #  for it, and the bend's held keyframes and the body's moves while standing
    #  linear for the same reason
    start = RISE if holding else STAND

    # The body straightens over STRAIGHTEN, the head and arms done SETTLE after
    #  it, and the animation ends there: the moves' last keyframes brought in to
    #  then, and any later keyframe dropped
    end = start + STRAIGHTEN + SETTLE
    for c in channels:
        if c in moves:
            for k in c["keys"]:
                if k["t"] == last:
                    k["t"] = end
        c["keys"] = [k for k in c["keys"] if k["t"] <= end]
    length -= last - end
    last = end

    up = last - SETTLE - start
    tucked = tucked or [0.0, 0.0, 0.0]

    def body_turn(t):
        u = (t - start) / up
        settle = smoothstep((t - (last - SETTLE)) / SETTLE)
        pitch = BEND + (-OVERSHOOT - BEND) * smoothstep(u) + OVERSHOOT * settle
        roll = SWAY * math.sin(2 * math.pi * min(1.0, max(0.0, (t - start) / (last - start)))) \
            * math.sin(math.pi * min(1.0, max(0.0, (t - start) / (last - start))))
        return [pitch, 0.0, roll]

    def head_turn(t):
        u = (t - start - HEAD_LAG) / up
        nod = NOD * math.sin(math.pi * min(1.0, max(0.0, (t - (last - SETTLE)) / SETTLE)))
        tilt = TILT * math.sin(math.pi * min(1.0, max(0.0, (t - start) / up)))
        lifted = 1 - smoothstep(u)
        return [tucked[0] * lifted + nod, tucked[1] * lifted, tucked[2] * lifted + tilt]

    def arm_turn(arm, t):
        u = (t - start - ARM_LAG[arm]) / (last - start - max(ARM_LAG.values()))
        hanging = [-BEND, 0.0, 0.0]
        return [hanging[i] + (ZOMBIE_ARMS[arm][i] - hanging[i]) * smoothstep(u) for i in range(3)]

    times = []
    t = start
    while t < last - 1e-6:
        times.append(round(t, 4))
        t += STEP
    times.append(last)
    turns = {"body": body_turn, "head": head_turn,
             "right_arm": lambda t: arm_turn("right_arm", t), "left_arm": lambda t: arm_turn("left_arm", t)}
    for bone, turn in turns.items():
        rotation = next(c for c in channels if c["bone"] == bone and c["target"] == "ROTATION")
        kept = [k for k in rotation["keys"] if k["t"] < start]
        if holding:
            for k in kept:
                if k["t"] >= STAND:
                    k["interp"] = "LINEAR"
        rotation["keys"] = kept + [{"t": t, "target": "ROTATION", "interp": "LINEAR",
                                    "v": [round(x, 3) for x in turn(t)]} for t in times]
    for c in moves:
        for k in c["keys"]:
            if k["t"] >= STAND:
                k["interp"] = "LINEAR"
    return WARDEN_RIG, channels, length


# --- the Blockbench project ---

def new_uuid():
    return str(uuid.uuid4())


def box_faces(u, v, w, h, d):
    """A box's faces as Blockbench lays them out from its texture corner, in
    texture pixels"""
    return {
        "north": {"uv": [u + d, v + d, u + d + w, v + d + h], "texture": 0},
        "east": {"uv": [u, v + d, u + d, v + d + h], "texture": 0},
        "south": {"uv": [u + d + w + d, v + d, u + d + w + d + w, v + d + h], "texture": 0},
        "west": {"uv": [u + d + w, v + d, u + d + w + d, v + d + h], "texture": 0},
        "up": {"uv": [u + d + w, v + d, u + d, v], "texture": 0},
        "down": {"uv": [u + d + w + w, v, u + d + w, v + d], "texture": 0},
    }


def write_project(rig, channels, length, texture_png):
    """Writes the rig and its animation as a Blockbench Generic Model"""
    absolute = {}
    for name, (parent, pivot, _) in rig.items():
        absolute[name] = list(pivot) if parent is None else [a + b for a, b in zip(absolute[parent], pivot)]

    elements, groups, ids = [], {}, {}
    for name, (parent, pivot, boxes) in rig.items():
        ids[name] = new_uuid()
        origin = to_upright(absolute[name])
        groups[name] = {"name": name, "origin": [round(c, 4) for c in origin], "color": 0, "uuid": ids[name],
                        "export": True, "isOpen": True, "locked": False, "visibility": True, "autouv": 0,
                        "children": []}
        for i, (u, v, mirror, start, size, grow) in enumerate(boxes):
            corner_a = to_upright([a + b for a, b in zip(absolute[name], start)])
            corner_b = to_upright([a + b + s for a, b, s in zip(absolute[name], start, size)])
            frm = [min(a, b) for a, b in zip(corner_a, corner_b)]
            to = [max(a, b) for a, b in zip(corner_a, corner_b)]
            box_id = new_uuid()
            elements.append({
                "name": name if i == 0 else name + "_layer", "box_uv": True, "rescale": False, "locked": False,
                "render_order": "default", "allow_mirror_modeling": True,
                "from": [round(c, 4) for c in frm], "to": [round(c, 4) for c in to],
                "autouv": 0, "color": 0, "origin": [round(c, 4) for c in origin],
                "uv_offset": [u, v], "mirror_uv": mirror, "inflate": grow,
                "faces": box_faces(u, v, *size), "type": "cube", "uuid": box_id,
            })
            groups[name]["children"].append(box_id)
    roots = []
    for name, (parent, _, _) in rig.items():
        (roots if parent is None else groups[parent]["children"]).append(groups[name])

    animators = {}
    for c in channels:
        animator = animators.setdefault(ids[c["bone"]], {"name": c["bone"], "type": "bone", "keyframes": []})
        for k in c["keys"]:
            keyframe = {
                "channel": c["target"].lower(), "data_points": [{"x": round(k["v"][0], 4), "y": round(k["v"][1], 4),
                                                                 "z": round(k["v"][2], 4)}],
                "uuid": new_uuid(), "time": k["t"], "color": -1, "interpolation": k["interp"].lower(),
            }
            if "handles" in k:
                keyframe.update({
                    "bezier_linked": True,
                    "bezier_left_time": [round(x, 4) for x in k["handles"]["left_t"]],
                    "bezier_left_value": [round(x, 4) for x in k["handles"]["left_v"]],
                    "bezier_right_time": [round(x, 4) for x in k["handles"]["right_t"]],
                    "bezier_right_value": [round(x, 4) for x in k["handles"]["right_v"]],
                })
            animator["keyframes"].append(keyframe)

    project = {
        "meta": {"format_version": "4.10", "model_format": "free", "box_uv": True},
        "name": NAME, "model_identifier": "", "visible_box": [1, 1, 0], "variable_placeholders": "",
        "variable_placeholder_buttons": [], "timeline_setups": [], "unhandled_root_fields": {},
        "resolution": {"width": TEXTURE_SIZE, "height": TEXTURE_SIZE},
        "elements": elements, "outliner": roots,
        "textures": [{
            "path": "", "name": NAME + ".png", "folder": "", "namespace": "", "id": "0",
            "width": TEXTURE_SIZE, "height": TEXTURE_SIZE, "uv_width": TEXTURE_SIZE, "uv_height": TEXTURE_SIZE,
            "particle": False, "render_mode": "default", "render_sides": "auto", "frame_time": 1,
            "frame_order_type": "loop", "frame_order": "", "frame_interpolate": False, "visible": True,
            "internal": True, "saved": False, "uuid": new_uuid(),
            "source": "data:image/png;base64," + base64.b64encode(texture_png).decode(),
        }],
        "animations": [{
            "uuid": new_uuid(), "name": ANIMATION, "loop": "once", "override": False, "length": length,
            "snapping": TICKS_PER_SECOND, "selected": True, "anim_time_update": "", "blend_weight": "",
            "start_delay": "", "loop_delay": "", "animators": animators,
        }],
    }
    with open(PROJECT, "w", newline="\r\n") as f:
        f.write(json.dumps(project, indent=1) + "\n")


def read_project():
    """The rig and channels of the Blockbench project's 'emerge' animation, and
    how long it lasts"""
    project = json.loads(PROJECT.read_text())
    cubes = {e["uuid"]: e for e in project["elements"] if e.get("type", "cube") == "cube"}

    rig, names = {}, {}

    def walk(group, parent, parent_origin):
        name = group["name"]
        names[group["uuid"]] = name
        origin = group.get("origin", [0, 0, 0])
        absolute = to_upright(origin)
        pivot = absolute if parent is None else [a - b for a, b in zip(absolute, parent_origin)]
        boxes = []
        for child in group.get("children", []):
            if isinstance(child, str):
                cube = cubes.get(child)
                if cube is None:
                    continue
                if not cube.get("box_uv", project["meta"].get("box_uv", True)):
                    sys.exit("box %s does not use box UV, which the baking needs" % cube["name"])
                if any(cube.get("rotation", [0, 0, 0])):
                    sys.exit("box %s is turned; turn its bone instead" % cube["name"])
                a, b = to_upright(cube["from"]), to_upright(cube["to"])
                low = [min(x, y) for x, y in zip(a, b)]
                high = [max(x, y) for x, y in zip(a, b)]
                start = [lo - ab for lo, ab in zip(low, absolute)]
                size = [hi - lo for hi, lo in zip(high, low)]
                u, v = cube.get("uv_offset", [0, 0])
                boxes.append((u, v, bool(cube.get("mirror_uv", False)), start, size, cube.get("inflate", 0)))
        # A bone's resting turn, which the animation adds to: Blockbench turns a
        #  bone the other way about x and y from the model part it stands for
        rx, ry, rz = group.get("rotation", [0, 0, 0])
        rig[name] = (parent, pivot, boxes, (math.radians(-rx), math.radians(-ry), math.radians(rz)))
        for child in group.get("children", []):
            if isinstance(child, dict):
                walk(child, name, absolute)

    for root in project["outliner"]:
        if isinstance(root, dict):
            walk(root, None, None)

    animation = next((a for a in project.get("animations", []) if a["name"] == ANIMATION), None)
    if animation is None:
        sys.exit("the project has no animation called '%s'" % ANIMATION)
    channels = []
    for key, animator in animation.get("animators", {}).items():
        name = names.get(key, animator.get("name"))
        if name not in rig:
            continue
        for target in ("rotation", "position"):
            keys = []
            for k in animator.get("keyframes", []):
                if k["channel"] != target:
                    continue
                point = k["data_points"][0]
                try:
                    v = [float(point.get(axis, 0) or 0) for axis in "xyz"]
                except ValueError:
                    sys.exit("a keyframe on %s holds an expression, not a number" % name)
                blend = {"linear": "LINEAR", "step": "STEP", "bezier": "BEZIER"}.get(k.get("interpolation", "linear"), "CATMULLROM")
                key = {"t": float(k["time"]), "target": target.upper(), "interp": blend, "v": v}
                if blend == "BEZIER":
                    key["handles"] = {
                        "left_t": [float(x) for x in k.get("bezier_left_time", [-0.1] * 3)],
                        "left_v": [float(x) for x in k.get("bezier_left_value", [0] * 3)],
                        "right_t": [float(x) for x in k.get("bezier_right_time", [0.1] * 3)],
                        "right_v": [float(x) for x in k.get("bezier_right_value", [0] * 3)],
                    }
                keys.append(key)
            keys.sort(key=lambda k: k["t"])
            if keys:
                channels.append({"bone": name, "target": target.upper(), "keys": keys})
    return rig, channels, float(animation["length"])


# --- the boxes and their faces ---

def polygons(u, v, mirror, low, high, size):
    """Each face of a box at texture u, v as the game builds a model part's box:
    its four corners in the part's pixels, y down, each with its texture pixel"""
    w, h, d = size
    x0, x1 = (high[0], low[0]) if mirror else (low[0], high[0])
    t0, t1, t2, t3 = (x0, low[1], low[2]), (x1, low[1], low[2]), (x1, high[1], low[2]), (x0, high[1], low[2])
    l0, l1, l2, l3 = (x0, low[1], high[2]), (x1, low[1], high[2]), (x1, high[1], high[2]), (x0, high[1], high[2])
    u0, u1, u2, u22, u3, u4 = u, u + d, u + d + w, u + d + w + w, u + d + w + d, u + d + w + d + w
    v0, v1, v2 = v, v + d, v + d + h

    def remap(corners, a0, b0, a1, b1):
        # The first corner takes the far u and near v, then round the rest
        return list(zip(corners, [(a1, b0), (a0, b0), (a0, b1), (a1, b1)]))

    return [
        remap([l1, l0, t0, t1], u1, v0, u2, v1),
        remap([t2, t3, l3, l2], u2, v1, u22, v0),
        remap([t0, l0, l3, t3], u0, v1, u1, v2),
        remap([t1, t0, t3, t2], u1, v1, u2, v2),
        remap([l1, t1, t2, l2], u2, v1, u3, v2),
        remap([l0, l1, l2, l3], u3, v1, u4, v2),
    ]


# A block model face's own edges, in the element's pixels: the axis its texture
#  u runs along and whether u grows along it, then the same for v
BLOCK_FACES = {
    "north": ("z", 0, ("x", False), ("y", False)),
    "south": ("z", 1, ("x", True), ("y", False)),
    "west": ("x", 0, ("z", True), ("y", False)),
    "east": ("x", 1, ("z", False), ("y", False)),
    "up": ("y", 1, ("x", True), ("z", True)),
    "down": ("y", 0, ("x", True), ("z", False)),
}
AXES = {"x": 0, "y": 1, "z": 2}


def element(box, turn, pivot):
    """The model element for one box of a part placed at 'turn' and 'pivot', in
    the model part's pixels, y down"""
    u, v, mirror, start, size, grow = box
    low = [s - grow for s in start]
    high = [s + z + grow for s, z in zip(start, size)]

    # Flipped as the game flips a mob: a half turn about z, so x and y run the
    #  other way and the box's least and most trade along them
    flipped_low = [-high[0], -high[1], low[2]]
    flipped_high = [-low[0], -low[1], high[2]]
    turn_w = mat_mul(FLIP, mat_mul(turn, FLIP))
    pivot_w = mat_vec(FLIP, pivot)

    # Feet at the model's middle, at MODEL_SCALE
    origin = [8 + MODEL_SCALE * pivot_w[0], 8 + MODEL_SCALE * (pivot_w[1] + GROUND), 8 + MODEL_SCALE * pivot_w[2]]
    frm = [origin[i] + MODEL_SCALE * flipped_low[i] for i in range(3)]
    to = [origin[i] + MODEL_SCALE * flipped_high[i] for i in range(3)]
    if min(frm + to) < LIMITS[0] or max(frm + to) > LIMITS[1]:
        sys.exit("a box leaves the model's limits: %s %s" % (frm, to))

    # Each face's corners flipped too, then read off as the block model face on
    #  that side: the texture pixel at its least and most along the axis its u
    #  runs, and the same for v
    model_faces = {}
    for corners in polygons(u, v, mirror, low, high, size):
        flipped = [((-x, -y, z), uv) for (x, y, z), uv in corners]
        held = [a for a in range(3) if len({round(p[a], 6) for p, _ in flipped}) == 1][0]
        end = 0 if round(flipped[0][0][held], 6) == round(flipped_low[held], 6) else 1
        name = next(n for n, (axis, side, _, _) in BLOCK_FACES.items() if AXES[axis] == held and side == end)
        _, _, (u_axis, u_grows), (v_axis, v_grows) = BLOCK_FACES[name]
        texture = []
        for axis, which in ((AXES[u_axis], 0), (AXES[v_axis], 1)):
            at_least = {uv[which] for p, uv in flipped if round(p[axis], 6) == round(min(q[axis] for q, _ in flipped), 6)}
            at_most = {uv[which] for p, uv in flipped if round(p[axis], 6) == round(max(q[axis] for q, _ in flipped), 6)}
            if len(at_least) != 1 or len(at_most) != 1:
                sys.exit("the %s face's texture would need turning, not flipping" % name)
            texture.append((at_least.pop(), at_most.pop()))
        (u_least, u_most), (v_least, v_most) = texture
        u_from, u_to = (u_least, u_most) if u_grows else (u_most, u_least)
        v_from, v_to = (v_least, v_most) if v_grows else (v_most, v_least)
        scale = 16 / TEXTURE_SIZE
        model_faces[name] = {"uv": [round(u_from * scale, 4), round(v_from * scale, 4),
                                    round(u_to * scale, 4), round(v_to * scale, 4)],
                             "texture": "#zombie"}

    x, y, z = zyx_angles(turn_w)
    return {
        "from": [round(c, 4) for c in frm],
        "to": [round(c, 4) for c in to],
        "rotation": {"origin": [round(c, 4) for c in origin], "x": round(x, 3), "y": round(y, 3), "z": round(z, 3)},
        "faces": model_faces,
    }


def write(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="\r\n") as f:
        f.write(text)


def bake(rig, channels, length):
    frames = int(round(length * TICKS_PER_SECOND))
    folder = ASSETS / "models" / "item" / NAME
    for old in folder.glob("*.json") if folder.exists() else []:
        old.unlink()
    entries = []
    for tick in range(frames):
        placed = pose(rig, channels, tick / TICKS_PER_SECOND)
        elements = [element(box, *placed[name]) for name, (_, _, boxes, *_) in rig.items() for box in boxes]
        lines = [
            "{",
            '  "textures": {"particle": "derailed:block/%s", "zombie": "derailed:block/%s"},' % (NAME, NAME),
            '  "elements": [',
        ]
        lines += ["    " + json.dumps(e, separators=(", ", ": ")) + ("," if i < len(elements) - 1 else "")
                  for i, e in enumerate(elements)]
        lines += ["  ]", "}"]
        write(folder / ("%03d.json" % tick), "\n".join(lines) + "\n")
        entries.append({"threshold": tick, "model": {"type": "minecraft:model", "model": "derailed:item/%s/%03d" % (NAME, tick)}})

    lines = ["{", '  "model": {', '    "type": "minecraft:range_dispatch",', '    "property": "minecraft:custom_model_data",',
             '    "index": 0,', '    "fallback": ' + json.dumps(entries[0]["model"], separators=(", ", ": ")) + ",",
             '    "entries": [']
    lines += ["      " + json.dumps(e, separators=(", ", ": ")) + ("," if i < len(entries) - 1 else "")
              for i, e in enumerate(entries)]
    lines += ["    ]", "  }", "}"]
    write(ASSETS / "items" / (NAME + ".json"), "\n".join(lines) + "\n")

    # The datapack reads how many frames there are from here, so a bake that
    #  changes how long it lasts changes where it ends
    write(ROOT / "datapack" / "data" / "derailed" / "function" / "emerge" / "_frames.mcfunction",
          "# Returns how many frames the emerging zombie has\n"
          "# Written by 'utils/generate_zombie_emerge.py'; run that again rather than\n"
          "#  editing this\n"
          "\n"
          "return %d\n" % frames)
    print("wrote", frames, "frames, the item", NAME, "and the frame count")
    return frames


def main():
    if not JAR.exists():
        sys.exit("no client jar at %s" % JAR)
    texture_png = zipfile.ZipFile(JAR).read("assets/minecraft/textures/entity/zombie/zombie.png")
    texture = ASSETS / "textures" / "block" / (NAME + ".png")
    width, height, pixels = _png.read(texture_png)
    _png.write(str(texture), width, height, pixels)

    if "--from-warden" in sys.argv:
        if PROJECT.exists() and "--force" not in sys.argv:
            sys.exit("%s is already there; add --force to write over it" % PROJECT.relative_to(ROOT))
        rig, channels, length = from_warden()
        write_project(rig, channels, length, texture_png)
        print("wrote", PROJECT.relative_to(ROOT))

    if not PROJECT.exists():
        sys.exit("no %s; write it with --from-warden" % PROJECT.relative_to(ROOT))
    bake(*read_project())


if __name__ == "__main__":
    main()
