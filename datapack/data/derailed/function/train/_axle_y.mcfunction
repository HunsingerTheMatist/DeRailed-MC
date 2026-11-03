# Stands this axle at the height team $(team)'s path runs at
# Run as the axle's marker

$execute store result entity @s Pos[1] double 0.001 run data get storage derailed:train t$(team).y
