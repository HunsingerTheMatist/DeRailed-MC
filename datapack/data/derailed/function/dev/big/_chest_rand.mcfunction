
# Takes a number at random from 0 to one less than '#ch_t' into '#ch_r', from
#  nothing fixed, or from 'derailed:terrain' where '#big_chest_seeded' is 1

execute if score #big_chest_seeded dr_var matches 1 store result score #ch_r dr_temp run random value 0..2147483646 derailed:terrain
execute unless score #big_chest_seeded dr_var matches 1 store result score #ch_r dr_temp run random value 0..2147483646
scoreboard players operation #ch_r dr_temp %= #ch_t dr_temp
