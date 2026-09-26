
# Counts the section's wood and iron tiles within reach column by column
#  into '#c_w' and '#c_i', and onto every seed of this section, as 'dr_c0' to
#  'dr_c31', how many tiles of its region within reach each column
#  holds, river left out, and all of them as 'dr_ctot'; and the wood and iron
#  tiles of regions the supply count cannot take, tagged 'dr_untake', into
#  '#rep_uw' and '#rep_ui'
# Positioned at the section's corner, on the visible layer, while the supply
#  check's flood is still laid

scoreboard players set #c_w0 dr_var 0
scoreboard players set #c_w1 dr_var 0
scoreboard players set #c_w2 dr_var 0
scoreboard players set #c_w3 dr_var 0
scoreboard players set #c_w4 dr_var 0
scoreboard players set #c_w5 dr_var 0
scoreboard players set #c_w6 dr_var 0
scoreboard players set #c_w7 dr_var 0
scoreboard players set #c_w8 dr_var 0
scoreboard players set #c_w9 dr_var 0
scoreboard players set #c_w10 dr_var 0
scoreboard players set #c_w11 dr_var 0
scoreboard players set #c_w12 dr_var 0
scoreboard players set #c_w13 dr_var 0
scoreboard players set #c_w14 dr_var 0
scoreboard players set #c_w15 dr_var 0
scoreboard players set #c_w16 dr_var 0
scoreboard players set #c_w17 dr_var 0
scoreboard players set #c_w18 dr_var 0
scoreboard players set #c_w19 dr_var 0
scoreboard players set #c_w20 dr_var 0
scoreboard players set #c_w21 dr_var 0
scoreboard players set #c_w22 dr_var 0
scoreboard players set #c_w23 dr_var 0
scoreboard players set #c_w24 dr_var 0
scoreboard players set #c_w25 dr_var 0
scoreboard players set #c_w26 dr_var 0
scoreboard players set #c_w27 dr_var 0
scoreboard players set #c_w28 dr_var 0
scoreboard players set #c_w29 dr_var 0
scoreboard players set #c_w30 dr_var 0
scoreboard players set #c_w31 dr_var 0
scoreboard players set #c_i0 dr_var 0
scoreboard players set #c_i1 dr_var 0
scoreboard players set #c_i2 dr_var 0
scoreboard players set #c_i3 dr_var 0
scoreboard players set #c_i4 dr_var 0
scoreboard players set #c_i5 dr_var 0
scoreboard players set #c_i6 dr_var 0
scoreboard players set #c_i7 dr_var 0
scoreboard players set #c_i8 dr_var 0
scoreboard players set #c_i9 dr_var 0
scoreboard players set #c_i10 dr_var 0
scoreboard players set #c_i11 dr_var 0
scoreboard players set #c_i12 dr_var 0
scoreboard players set #c_i13 dr_var 0
scoreboard players set #c_i14 dr_var 0
scoreboard players set #c_i15 dr_var 0
scoreboard players set #c_i16 dr_var 0
scoreboard players set #c_i17 dr_var 0
scoreboard players set #c_i18 dr_var 0
scoreboard players set #c_i19 dr_var 0
scoreboard players set #c_i20 dr_var 0
scoreboard players set #c_i21 dr_var 0
scoreboard players set #c_i22 dr_var 0
scoreboard players set #c_i23 dr_var 0
scoreboard players set #c_i24 dr_var 0
scoreboard players set #c_i25 dr_var 0
scoreboard players set #c_i26 dr_var 0
scoreboard players set #c_i27 dr_var 0
scoreboard players set #c_i28 dr_var 0
scoreboard players set #c_i29 dr_var 0
scoreboard players set #c_i30 dr_var 0
scoreboard players set #c_i31 dr_var 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c0 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c1 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c2 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c3 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c4 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c5 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c6 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c7 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c8 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c9 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c10 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c11 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c12 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c13 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c14 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c15 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c16 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c17 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c18 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c19 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c20 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c21 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c22 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c23 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c24 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c25 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c26 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c27 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c28 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c29 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c30 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_c31 0
scoreboard players set @e[type=marker,tag=dr_seed,distance=0..] dr_ctot 0
scoreboard players set #rep_uw dr_var 0
scoreboard players set #rep_ui dr_var 0
execute positioned ~0 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:0}
execute positioned ~1 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:1}
execute positioned ~2 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:2}
execute positioned ~3 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:3}
execute positioned ~4 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:4}
execute positioned ~5 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:5}
execute positioned ~6 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:6}
execute positioned ~7 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:7}
execute positioned ~8 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:8}
execute positioned ~9 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:9}
execute positioned ~10 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:10}
execute positioned ~11 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:11}
execute positioned ~12 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:12}
execute positioned ~13 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:13}
execute positioned ~14 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:14}
execute positioned ~15 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:15}
execute positioned ~16 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:16}
execute positioned ~17 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:17}
execute positioned ~18 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:18}
execute positioned ~19 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:19}
execute positioned ~20 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:20}
execute positioned ~21 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:21}
execute positioned ~22 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:22}
execute positioned ~23 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:23}
execute positioned ~24 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:24}
execute positioned ~25 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:25}
execute positioned ~26 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:26}
execute positioned ~27 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:27}
execute positioned ~28 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:28}
execute positioned ~29 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:29}
execute positioned ~30 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:30}
execute positioned ~31 ~ ~ run function derailed:dev/gen/_rep_scan_col {c:31}
