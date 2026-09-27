
# Lays the piece over columns $(x) to $(x1) and rows $(z) to $(zl) in $(block),
#  with $(glass) over it on the marker layer, marks its northwestern tile as a
#  'dr_piece' tagged $(tag) holding '#pc_n' creatures, and keeps it in
#  'pieces' for the growth to lay again
# Positioned at the section's corner

$fill ~$(x) ~ ~$(z) ~$(x1) ~ ~$(zl) $(block) strict
$fill ~$(x) ~16 ~$(z) ~$(x1) ~16 ~$(zl) $(glass) strict
$execute positioned ~$(x) ~ ~$(z) summon marker run function derailed:dev/gen/_piece_new {tag:"$(tag)"}
data modify storage derailed:gen pieces append from storage derailed:gen pc
