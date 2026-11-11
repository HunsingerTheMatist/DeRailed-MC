
# Builds a column '#mH' pixels high from here up, of whole blocks with
#  whatever of the kind's tops tops them nearest what is left over
# Positioned at the column's foot

# How many whole blocks, and what tops them: '#mtopi' the tall top block in
#  place of the top whole block and '#mcap' the slab over them, each -1 for
#  none
scoreboard players operation #mk dr_temp = #mH dr_temp
scoreboard players operation #mk dr_temp /= #m16 dr_temp
scoreboard players operation #mH dr_temp %= #m16 dr_temp
scoreboard players set #mtopi dr_temp -1
scoreboard players set #mcap dr_temp -1
execute if score #mound_kind dr_arg matches 0 run function derailed:mound/_quant_iron
execute if score #mound_kind dr_arg matches 1 run function derailed:mound/_quant_rock

execute if score #mound_kind dr_arg matches 0 run function derailed:mound/_column_iron
execute if score #mound_kind dr_arg matches 1 run function derailed:mound/_column_rock
