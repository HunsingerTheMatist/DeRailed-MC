
# Gives this cut tile the region of the first tile next to it, then at a corner,
#  that is the same terrain and has a region to give
# Positioned on the tile, on the visible layer

execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:1,z:0}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:-1,z:0}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:0,z:1}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:0,z:-1}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:1,z:1}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:1,z:-1}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:-1,z:1}
execute if block ~ ~-2 ~ air run function derailed:dev/gen/_cut_own_try {x:-1,z:-1}
