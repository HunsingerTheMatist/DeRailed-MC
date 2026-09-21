
# Takes down the kind this edge tile ended up drawn as
# Run as the note, once the section is settled and painted

# 'derailed:dev/gen/_read_kind' only writes on a match, so a tile that is none of
#  the kinds - river water, most of all - would otherwise keep whatever the note
#  before it read
scoreboard players set #gen_kind dr_var -1
function derailed:dev/gen/_read_kind
scoreboard players operation @s dr_kind = #gen_kind dr_var
