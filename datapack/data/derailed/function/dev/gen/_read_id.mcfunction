# Reads the region back out of the block on this tile, a bit at a time, in one
#  go: 'derailed:gen/region_id' adds up the bits whose tags, 'region_id/bit_1'
#  to 'region_id/bit_16', hold the block, in the order of the palette in 'load'
# A block that is no region's leaves '#gen_id' as it was
# Ids 26 to 30 are the regions carried over the western seam, which keep the kind
#  they had in the section before

execute if block ~ ~ ~ #derailed:region_id/any store result score #gen_id dr_var run compute block ~ ~ ~ integer derailed:gen/region_id
