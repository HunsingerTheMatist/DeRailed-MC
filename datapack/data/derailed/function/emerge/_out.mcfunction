# Puts a zombie where this emerging zombie's display stands, facing its way,
#  groaning as it stands, and removes the display
# Run as the emerging zombie's display, at it

playsound minecraft:entity.zombie.ambient hostile @a ~ ~ ~ 1 1
summon zombie ~ ~ ~ {Tags:["dr_emerge_out"]}
execute rotated as @s run tp @n[type=zombie,tag=dr_emerge_out,distance=..0.1] ~ ~ ~ ~ 0
tag @n[type=zombie,tag=dr_emerge_out,distance=..0.1] remove dr_emerge_out
kill @s
