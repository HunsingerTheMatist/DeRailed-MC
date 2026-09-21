
# Reads a note from the section before and retires it
# Run as the note

scoreboard players add #seam_seen dr_var 1
scoreboard players operation #seam_kind dr_var = @s dr_kind
scoreboard players operation #seam_wave dr_var = @s dr_wave
kill @s

# A note with no kind on it sat under water or under a section that never
#  settled, and there is no region to carry over
execute if score #seam_kind dr_var matches 0.. run scoreboard players set #seam_has dr_var 1
execute if score #seam_kind dr_var matches 0.. run scoreboard players add #seam_ok dr_var 1
