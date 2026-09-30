
# Marks this river tile 'dr_shore' where a lake's water lies along one of its
#  edges, and otherwise 'dr_shore_near' where it lies at one of its corners
# Positioned on the tile

execute if block ~1 ~ ~ blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore"]}
execute if block ~-1 ~ ~ blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore"]}
execute if block ~ ~ ~1 blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore"]}
execute if block ~ ~ ~-1 blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore"]}

execute if block ~1 ~ ~1 blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore_near"]}
execute if block ~1 ~ ~-1 blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore_near"]}
execute if block ~-1 ~ ~1 blue_concrete run return run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore_near"]}
execute if block ~-1 ~ ~-1 blue_concrete run summon marker ~ ~ ~ {Tags:["dr_lakeside","dr_shore_near"]}
