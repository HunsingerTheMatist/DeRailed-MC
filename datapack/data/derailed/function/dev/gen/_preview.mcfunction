
# Covers this section, a block over its visible layer wherever that is air,
#  with black concrete on every tile but its preview, clearing any a preview
#  laid there before: the tiles a region carried over the seam took, which are
#  the blocks of '#derailed:gen_is_kind' on the layer the regions grow on, but
#  those the section changed, and the yard of the station before, its bedrock
#  in the first two columns
# Positioned at the section's corner

fill ~ ~16 ~ ~31 ~16 ~15 air replace black_concrete strict
scoreboard players set #pv_c dr_var 0
function derailed:dev/gen/_preview_col
