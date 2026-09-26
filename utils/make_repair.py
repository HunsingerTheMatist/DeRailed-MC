"""Writes the repair's column functions for the terrain generator.

The repair scores a section by how short its windows, its tail and its totals
fall of wood and iron, and scores every swap it might make before making the
best one. Scoring means sliding a window along 61 columns for two kinds, and
doing that with lists and macros for every candidate swap is slow, so the
columns are fake players and the functions that add them up are written out in
full here instead.

Run it from the repo root after changing the section width, the window width
or the tail width:

    py -3 utils/make_repair.py
"""

import io
import os

WIDTH = 32   # columns in a section
SPAN = 30    # columns in a window
TAIL = 15    # columns in a section's tail
ROWS = 16    # rows in a section

PREV = SPAN - 1                 # columns of the section before a window can reach
WINDOWS = WIDTH                 # windows ending in a section, the first ending on its first column
TAIL_FROM = WIDTH - TAIL

OUT = os.path.join("datapack", "data", "derailed", "function", "dev", "gen")
NS = "derailed:dev/gen"


def write(name, lines):
    path = os.path.join(OUT, name + ".mcfunction")
    with io.open(path, "w", encoding="utf-8", newline="\r\n") as f:
        f.write("\n".join(lines) + "\n")


def header(*text):
    """A comment block: each line after the first carries on the thought
    before it, unless it starts with '^', which starts a new one."""
    lines = ["# " + text[0]]
    for t in text[1:]:
        lines.append("# " + t[1:] if t.startswith("^") else "#  " + t)
    return [""] + lines + [""]


# The candidate columns start as the section's own
write("_rep_vload", header(
    "Starts the candidate columns '#v_w' and '#v_i' off as the section's own,",
    "'#c_w' and '#c_i', for a change to be tried on, and the tiles the supply",
    "count cannot take, '#v_uw' and '#v_ui', off as the section's, '#rep_uw' and",
    "'#rep_ui'") + [
    f"scoreboard players operation #v_{k}{c} dr_var = #c_{k}{c} dr_var"
    for k in "wi" for c in range(WIDTH)] + [
    "scoreboard players operation #v_uw dr_var = #rep_uw dr_var",
    "scoreboard players operation #v_ui dr_var = #rep_ui dr_var"])

# A region's tiles, column by column, going into or out of a kind
for kind, word in (("w", "wood"), ("i", "iron")):
    for op, verb, sign in (("add", "Adds", "+="), ("sub", "Takes", "-=")):
        write(f"_rep_v{kind}_{op}", header(
            f"{verb} this region's tiles within reach, column by column,",
            f"{'to' if op == 'add' else 'from'} the candidate {word} columns",
            "^A region the supply count cannot take counts toward the windows",
            "but not the totals, so its tiles go into or out of those it cannot take",
            "as well",
            "^Run as the region's seed") + [
            f"scoreboard players operation #v_{kind}{c} dr_var {sign} @s dr_c{c}"
            for c in range(WIDTH)] + [
            f"execute if entity @s[tag=dr_untake] run scoreboard players operation #v_u{kind} dr_var {sign} @s dr_ctot"])

# The score, a function for each kind and one for both
for kind, word in (("w", "wood"), ("i", "iron")):
    ev = header(
        f"Scores the candidate {word} columns into '#rep_s{kind}': every window's",
        "shortfall, the tail's, and the total's weighed '#rep_total_weight' times",
        "^A window is the section before's last columns, then this section's; the",
        "first section has none before it, and its windows start on its own first",
        "column",
        "^The total is what the supply count can take: every tile within reach",
        "but those of regions it cannot take")
    out = f"#rep_s{kind}"
    ev.append(f"scoreboard players set {out} dr_var 0")
    col = lambda j: f"#p_{kind}{j}" if j < PREV else f"#v_{kind}{j - PREV}"
    ev.append("scoreboard players set #rep_s dr_var 0")
    for j in range(SPAN):
        ev.append(f"scoreboard players operation #rep_s dr_var += {col(j)} dr_var")
    for k in range(WINDOWS):
        if k > 0:
            ev.append(f"scoreboard players operation #rep_s dr_var += {col(k + SPAN - 1)} dr_var")
            ev.append(f"scoreboard players operation #rep_s dr_var -= {col(k - 1)} dr_var")
        guard = "execute if score #rep_first dr_var matches 0 run " if k < PREV else ""
        ev.append(f"{guard}scoreboard players operation #rep_d dr_var = #sp_need dr_var")
        ev.append(f"{guard}scoreboard players operation #rep_d dr_var -= #rep_s dr_var")
        ev.append(f"{'execute if score #rep_first dr_var matches 0 ' if k < PREV else 'execute '}if score #rep_d dr_var matches 1.. run scoreboard players operation {out} dr_var += #rep_d dr_var")

    ev.append("")
    ev.append("scoreboard players operation #rep_d dr_var = #gen_tail_need dr_var")
    for c in range(TAIL_FROM, WIDTH):
        ev.append(f"scoreboard players operation #rep_d dr_var -= #v_{kind}{c} dr_var")
    ev.append(f"execute if score #rep_d dr_var matches 1.. run scoreboard players operation {out} dr_var += #rep_d dr_var")

    total = "#need_wood" if kind == "w" else "#need_iron"
    ev.append("")
    ev.append(f"scoreboard players operation #rep_d dr_var = {total} dr_var")
    ev.append(f"scoreboard players operation #rep_d dr_var += #v_u{kind} dr_var")
    for c in range(WIDTH):
        ev.append(f"scoreboard players operation #rep_d dr_var -= #v_{kind}{c} dr_var")
    ev.append("execute if score #rep_d dr_var matches 1.. run scoreboard players operation #rep_d dr_var *= #rep_total_weight dr_var")
    ev.append(f"execute if score #rep_d dr_var matches 1.. run scoreboard players operation {out} dr_var += #rep_d dr_var")
    write(f"_rep_eval_{kind}", ev)

write("_rep_eval", header(
    "Scores the candidate columns of both kinds into '#rep_sw' and '#rep_si', and",
    "the two together into '#rep_score'") + [
    f"function {NS}/_rep_eval_w",
    f"function {NS}/_rep_eval_i",
    "scoreboard players operation #rep_score dr_var = #rep_sw dr_var",
    "scoreboard players operation #rep_score dr_var += #rep_si dr_var"])

# What the repair takes the totals to be, for the report
write("_rep_totals", header(
    "Adds up what the repair takes the section's totals to be, the wood and iron",
    "tiles within reach but those of regions the supply count cannot take, into",
    "'#rep_tw' and '#rep_ti'") + [
    "scoreboard players operation #rep_tw dr_var = #rep_uw dr_var",
    "scoreboard players operation #rep_tw dr_var *= $NegOne dr_const",
    "scoreboard players operation #rep_ti dr_var = #rep_ui dr_var",
    "scoreboard players operation #rep_ti dr_var *= $NegOne dr_const"] + [
    f"scoreboard players operation #rep_t{k} dr_var += #c_{k}{c} dr_var"
    for k in "wi" for c in range(WIDTH)])

# The section before's columns
write("_rep_prev", header(
    "Takes the section before's last columns, the ones a window of this",
    "section can reach, out of 'prev_cols' into '#p_w' and '#p_i'") + [
    f"execute store result score #p_{k}{j} dr_var run data get storage derailed:gen prev_cols[{WIDTH - PREV + j}].{k}"
    for k in "wi" for j in range(PREV)])

# The scan
scan = header(
    "Counts the section's wood and iron tiles within reach column by column",
    "into '#c_w' and '#c_i', and onto every seed of this section, as 'dr_c0' to",
    f"'dr_c{WIDTH - 1}', how many tiles of its region within reach each column",
    "holds, river left out, and all of them as 'dr_ctot'; and the wood and iron",
    "tiles of regions the supply count cannot take, tagged 'dr_untake', into",
    "'#rep_uw' and '#rep_ui'",
    "^Positioned at the section's corner, on the visible layer, while the supply",
    "check's flood is still laid")
scan += [f"scoreboard players set #c_{k}{c} dr_var 0" for k in "wi" for c in range(WIDTH)]
scan += [f"scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c{c} 0" for c in range(WIDTH)]
scan += ["scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_ctot 0",
         "scoreboard players set #rep_uw dr_var 0",
         "scoreboard players set #rep_ui dr_var 0"]
scan += [f"execute positioned ~{c} ~ ~ run function {NS}/_rep_scan_col {{c:{c}}}" for c in range(WIDTH)]
write("_rep_scan", scan)

write("_rep_scan_col", header(
    "Counts every tile of column $(c) for the scan",
    "^Positioned on the column's northern tile") + [
    f"$execute positioned ~ ~ ~{z} run function {NS}/_rep_tile {{c:$(c)}}" for z in range(ROWS)])

write("_rep_objectives", header(
    "Adds the scores a seed holds its region's tiles within reach in, one for",
    "each of a section's columns, for the repair") + [
    f'scoreboard objectives add dr_c{c} dummy "DeRailed Region Tiles In Column {c}"' for c in range(WIDTH)] + [
    'scoreboard objectives add dr_ctot dummy "DeRailed Region Tiles In Reach"'])

print("written")
