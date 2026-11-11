# Digs a tile of lake, three by three, centred on the block the player stands
#  on, with the interaction a bucket is filled at, as 'dev/big/build' lays one
# Run by a player standing on the ground

execute align xyz run place template derailed:lake ~-1 ~-5 ~-1 none none 1 0 strict
execute align xyz positioned ~0.5 ~-3 ~0.5 run summon interaction ~ ~ ~ {Tags:["dr_water"],width:3f,height:2.875f}
