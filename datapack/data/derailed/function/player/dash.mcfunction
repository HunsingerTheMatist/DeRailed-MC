# Start a dash. Run as the player
#
# The impulse comes from an enchantment rather than a speed attribute, so it is
#  real momentum that carries the player rather than a higher speed cap they
#  have to keep running into. 'apply_impulse' also marks the velocity for sync
#  and grants anti-cheat grace, which setting Motion on a player does not
#
# The saddle slot holds it because survival play cannot reach that slot, so
#  nothing the player does can interfere, on the saddle 'player/saddle' gives,
#  with its enchantments kept

item replace entity @s saddle with minecraft:saddle[enchantments={"derailed:dash":1,"derailed:burn":1,"minecraft:vanishing_curse":1},custom_data={dr_saddle:true}]

scoreboard players operation @s dr_dash_burst = $DashBurst dr_config
scoreboard players operation @s dr_dash_cd = $DashCooldown dr_config
