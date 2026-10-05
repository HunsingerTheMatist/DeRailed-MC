
# Tints the water wagon's tank with the tank tint for '$(step)' hundredths of
#  its water used
# Run as the water wagon's item display

$data modify entity @s item.components."minecraft:custom_model_data".colors[0] set from storage derailed:train tank_tint[$(step)]
