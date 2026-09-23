
# Copies the tile to the north onto this one, or failing that the first other
#  tile beside it that is terrain rather than river; with river all round it
#  stays as it is
# Positioned on the tile

execute unless block ~ ~9 ~-1 magenta_glazed_terracotta if block ~ ~5 ~-1 #derailed:gen_is_kind run return run function derailed:dev/gen/_stray_from {x:0,z:-1}
execute unless block ~ ~9 ~1 magenta_glazed_terracotta if block ~ ~5 ~1 #derailed:gen_is_kind run return run function derailed:dev/gen/_stray_from {x:0,z:1}
execute unless block ~-1 ~9 ~ magenta_glazed_terracotta if block ~-1 ~5 ~ #derailed:gen_is_kind run return run function derailed:dev/gen/_stray_from {x:-1,z:0}
execute unless block ~1 ~9 ~ magenta_glazed_terracotta if block ~1 ~5 ~ #derailed:gen_is_kind run return run function derailed:dev/gen/_stray_from {x:1,z:0}
