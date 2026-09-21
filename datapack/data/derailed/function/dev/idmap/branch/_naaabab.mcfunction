# Narrows the region id to 13..14

execute if score #idmap_id dr_var matches 13..13 run function derailed:dev/idmap/branch/_naaababa
execute if score #idmap_id dr_var matches 14..14 run function derailed:dev/idmap/branch/_naaababb
