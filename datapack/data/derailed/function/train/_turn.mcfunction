
# Turns this piece's model and its wheels to the way the piece faces through
#  their transformations, then sets the piece's own facing back to none
# The client is sent an entity's facing in steps of a 256th of a turn, which
#  jitters a degree or so either way, while a transformation reaches it whole
#  and blends into place over its 'interpolation_duration'
# A display turns by its facing reversed, so the model turns that way round
# Run as the piece's item display, facing the way the piece faces

data modify storage derailed:train rot set value {angle:0f,axis:[0f,1f,0f]}
execute store result storage derailed:train rot.angle float -0.0000174533 run data get entity @s Rotation[0] 1000
data modify entity @s transformation.left_rotation set from storage derailed:train rot
data modify entity @s start_interpolation set value 0
function derailed:train/_wheels
rotate @s 0 0
