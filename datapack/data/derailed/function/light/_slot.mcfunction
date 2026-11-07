# Returns the first number in 'dr_light' of the lowest slot no light has, 256
#  for each slot, or -1 if every slot is taken
# Run in the game's dimension

execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=0..255}] run return 0
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=256..511}] run return 256
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=512..767}] run return 512
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=768..1023}] run return 768
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=1024..1279}] run return 1024
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=1280..1535}] run return 1280
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=1536..1791}] run return 1536
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=1792..2047}] run return 1792
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=2048..2303}] run return 2048
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=2304..2559}] run return 2304
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=2560..2815}] run return 2560
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=2816..3071}] run return 2816
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=3072..3327}] run return 3072
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=3328..3583}] run return 3328
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=3584..3839}] run return 3584
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=3840..4095}] run return 3840
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=4096..4351}] run return 4096
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=4352..4607}] run return 4352
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=4608..4863}] run return 4608
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=4864..5119}] run return 4864
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=5120..5375}] run return 5120
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=5376..5631}] run return 5376
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=5632..5887}] run return 5632
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=5888..6143}] run return 5888
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=6144..6399}] run return 6144
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=6400..6655}] run return 6400
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=6656..6911}] run return 6656
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=6912..7167}] run return 6912
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=7168..7423}] run return 7168
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=7424..7679}] run return 7424
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=7680..7935}] run return 7680
execute unless entity @e[type=item_display,tag=dr_light,distance=0..,scores={dr_light=7936..8191}] run return 7936
return -1
