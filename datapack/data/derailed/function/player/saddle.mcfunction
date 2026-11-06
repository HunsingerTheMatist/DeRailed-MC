# Puts the saddle that carries the enchantments acting on this player in their
#  saddle slot, which survival play cannot reach: 'derailed:burn', which sets
#  them on fire while they touch a burning piece of a train
# Run as the player

item replace entity @s saddle with minecraft:saddle[enchantments={"derailed:burn":1,"minecraft:vanishing_curse":1},custom_data={dr_saddle:true}]
