
# Marks this cell as lying in the pinched run being counted, once
# Positioned on the cell

execute unless entity @n[type=marker,tag=dr_pinch,distance=..0.4] summon marker run function derailed:dev/gen/_pinch_marked
