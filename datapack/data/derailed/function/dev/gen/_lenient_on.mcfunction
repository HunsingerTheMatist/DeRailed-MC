
# Loosens the section being built, as a last resort, in the two checks the
#  section before can make impossible: the windows that are more its columns
#  than this section's are left out, and the wood within reach in its last
#  columns counts as in hand for the order; and counts it for the report

scoreboard players set #gen_lenient dr_var 1
scoreboard players add #gen_lenient_sections dr_var 1
function derailed:dev/gen/_carry_in
execute if score #q_log dr_var matches 1 run tellraw @a [{text:"[q] section ",color:"gray"},{score:{name:"#gen_section",objective:"dr_var"}}," loosened, with ",{score:{name:"#gen_carry_in",objective:"dr_var"}}," wood carried in"]
