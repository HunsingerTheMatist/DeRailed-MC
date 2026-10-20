# Steps this emerging zombie on a frame, throwing up the ground it climbs out of
#  for the first 4.5 seconds as a warden does, groaning as its head breaks the
#  surface at frame 16, and puts the zombie itself in its place after the last
#  frame, as many as 'emerge/_frames' says there are
# Run as the emerging zombie's display, at it

scoreboard players add @s dr_emerge 1
execute store result score #emerge_frames dr_temp run function derailed:emerge/_frames
execute if score @s dr_emerge >= #emerge_frames dr_temp run return run function derailed:emerge/_out
item modify entity @s contents derailed:emerge_frame
execute if score @s dr_emerge matches ..89 run function derailed:emerge/_dig
execute if score @s dr_emerge matches 16 run playsound minecraft:entity.zombie.ambient hostile @a ~ ~ ~ 1 1
