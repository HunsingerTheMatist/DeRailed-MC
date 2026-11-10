
# Succeeds where any of the eight tiles round this one is the wall's and not
#  river, corners included, since the wall holds its line through a corner too
# Positioned on the tile

execute unless block ~1 ~9 ~ magenta_glazed_terracotta positioned ~1 ~5 ~ if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~-1 ~9 ~ magenta_glazed_terracotta positioned ~-1 ~5 ~ if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~ ~9 ~1 magenta_glazed_terracotta positioned ~ ~5 ~1 if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~ ~9 ~-1 magenta_glazed_terracotta positioned ~ ~5 ~-1 if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~1 ~9 ~1 magenta_glazed_terracotta positioned ~1 ~5 ~1 if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~1 ~9 ~-1 magenta_glazed_terracotta positioned ~1 ~5 ~-1 if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~-1 ~9 ~1 magenta_glazed_terracotta positioned ~-1 ~5 ~1 if function derailed:dev/gen/_stray_is_wall run return 1
execute unless block ~-1 ~9 ~-1 magenta_glazed_terracotta positioned ~-1 ~5 ~-1 if function derailed:dev/gen/_stray_is_wall run return 1
return 0
