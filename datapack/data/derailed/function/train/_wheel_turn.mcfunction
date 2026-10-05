
# Turns this wheel the way its piece faces, from 'rot', and rolls it by 'spin',
#  blending into place over its 'interpolation_duration'
# Run as the wheel's item display

data modify entity @s transformation.left_rotation set from storage derailed:train rot
data modify entity @s transformation.right_rotation set from storage derailed:train spin
data modify entity @s start_interpolation set value 0
