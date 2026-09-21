
# Leaves this tile for the carried region to reach on the wave it is due
# The eight rotating tags only carry delays up to 7, so anything further off
#  waits on a score instead and is woken by 'dev/gen/_wave'

execute summon marker run function derailed:dev/gen/_seam_wait
scoreboard players add #gen_waiting dr_var 1
