
# Clears the whole test area, every layer of it
# Positions itself, so it is safe to call from anywhere

# All of the stack has to go, not just the layers a section ends up showing: a
#  search knows it has reached a border by the tiles beyond it being air, so
#  anything an earlier run left standing out there reads as more section to walk
#  through and the river finds no way out
# It takes two fills because the whole stack at once is past what one will move
execute in derailed:game run fill 999 0 -1 1144 8 16 air strict
execute in derailed:game run fill 999 9 -1 1144 17 16 air strict
