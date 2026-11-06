# Empties this player's full bucket over the piece of their train they clicked,
#  tagged 'dr_wagon_clicked': the engine and the water wagon share the water,
#  so either refills the tank and puts both out; any other piece is put out
#  where it is burning, and otherwise the bucket is refused
# Run as the player

execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_engine,distance=0..] run return run function derailed:train/_refill
execute if entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_train_water,distance=0..] run return run function derailed:train/_refill
execute unless entity @e[type=item_display,tag=dr_wagon_clicked,tag=dr_burning,distance=0..] run return run function derailed:item/reject
execute as @e[type=item_display,tag=dr_wagon_clicked,distance=0..] run function derailed:train/extinguish
function derailed:item/bucket/empty
