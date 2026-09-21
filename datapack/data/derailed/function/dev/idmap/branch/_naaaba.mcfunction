# Narrows the region id to 10..14

execute if score #idmap_id dr_var matches 10..12 run function derailed:dev/idmap/branch/_naaabaa
execute if score #idmap_id dr_var matches 13..14 run function derailed:dev/idmap/branch/_naaabab
