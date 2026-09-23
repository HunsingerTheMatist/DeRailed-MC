
# Builds the next section on the tier already set, and says what its route cost
#  a rail against the tier's bounds
# A run being timed says nothing, the same as the report

function derailed:dev/gen/next_section

execute if score #gen_report dr_var matches 1 run tellraw @a [{text:"[gen] section ",color:"gray"},{score:{name:"#gen_section",objective:"dr_var"}},{text:" on tier "},{score:{name:"#gen_difficulty",objective:"dr_var"}},{text:": cost "},{score:{name:"#gen_cost",objective:"dr_var"}},{text:" over "},{score:{name:"#gen_route",objective:"dr_var"}},{text:" rails, "},{score:{name:"#gen_rate_raw",objective:"dr_var"}},{text:" a rail, "},{score:{name:"#gen_rate",objective:"dr_var"}},{text:" with the length counted, against "},{score:{name:"#gen_rate_min",objective:"dr_var"}},{text:" to "},{score:{name:"#gen_rate_max",objective:"dr_var"}},{text:", valid "},{score:{name:"#gen_valid",objective:"dr_var"}}]
