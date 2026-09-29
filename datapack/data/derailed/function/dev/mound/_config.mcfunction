
# What each kind of mound is built of and how it rises, one entry a kind
# 'full' is a whole block, 16 pixels; 'tops' are whole blocks drawn higher, used
#  as a column's top block, and 'caps' slabs drawn in the block above a
#  column's whole blocks, which of them tops a column being worked out by the
#  function 'quant' names; every corner starts between 'smin' and 'smax'
#  pixels high, taken at random, and no column stands lower than 'smin' or
#  higher than 'max'; 'rise' is how many pixels above that start a corner
#  stands, by how many tiles in from the region's edge it is, the last used for
#  any further in; every corner inside a region is nudged up to 'noise' pixels
#  either way, every tile's nine columns together up to 'tjit' and every
#  column on its own up to 'jit'; up to 'peaks' corners two or more tiles in
#  are raised twice 'pk' pixels and every corner beside them 'pk'; a tile has a
#  'spike' in a hundred chance of the two by two columns in one of its corners
#  standing 'spikepx' higher; every
#  corner rises between 'rmin' and 'rmax' percent of its rise, taken at random;
#  and with 'round' set, depth counts the tiles at a corner only every other
#  step, so a mound's rings come out eight-sided rather than square
# Iron tops out 0, 4, 8 or 12 pixels above a whole number of blocks, the 4 a
#  tall top block and the 8 and 12 slabs; rock tops out 0, 6 or 12, both tall
#  top blocks

data modify storage derailed:mound kinds set value {iron:{full:"basalt[axis=y]",tops:["basalt[axis=x]"],caps:["sandstone_slab[type=bottom]","smooth_sandstone_slab[type=bottom]"],quant:"iron",smin:21,smax:32,max:80,rise:[0,20,34,44,50,54],noise:4,tjit:0,jit:2,peaks:3,pk:6,spike:0,spikepx:16,rmin:100,rmax:100,round:0},rock:{full:"deepslate[axis=y]",tops:["deepslate[axis=x]","deepslate[axis=z]"],caps:[],quant:"rock",smin:28,smax:44,max:240,rise:[0,105,171,204,204,204],noise:16,tjit:8,jit:4,peaks:5,pk:14,spike:25,spikepx:24,rmin:60,rmax:100,round:1}}
