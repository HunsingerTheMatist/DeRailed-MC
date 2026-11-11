
# Lays the start station's seven rails, straight east along its rail row from
#  the tile under the western tile of its building, each tile a track tile on
#  no team's track tagged 'dr_track_start' until 'dev/track/station' makes them
#  a team's
# Positioned at the northwestern block of the western tile of its building, two
#  below the ground

scoreboard players set #din dr_temp 1
scoreboard players set #dout dr_temp 1
execute positioned ~ ~2 ~3 run function derailed:track/lay_rails
execute positioned ~3 ~2 ~3 run function derailed:track/lay_rails
execute positioned ~6 ~2 ~3 run function derailed:track/lay_rails
execute positioned ~9 ~2 ~3 run function derailed:track/lay_rails
execute positioned ~12 ~2 ~3 run function derailed:track/lay_rails
execute positioned ~15 ~2 ~3 run function derailed:track/lay_rails
execute positioned ~18 ~2 ~3 run function derailed:track/lay_rails
execute align xyz positioned ~1.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
execute align xyz positioned ~4.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
execute align xyz positioned ~7.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
execute align xyz positioned ~10.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
execute align xyz positioned ~13.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
execute align xyz positioned ~16.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
execute align xyz positioned ~19.5 ~2.5 ~4.5 run summon marker ~ ~ ~ {Tags:["dr_track_tile","dr_track_start"]}
