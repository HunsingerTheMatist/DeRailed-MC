
# Reports how often sections needed their terrain rerolled since the counts were
#  last cleared, and which check turned them away

# A run that is being timed says nothing: a few hundred maps worth of this is a
#  few thousand lines of chat, which costs the client enough to muddy what the
#  profiler has to say about it
execute if score #gen_report dr_var matches 0 run return 0

tellraw @a [{text:"[gen] rerolls: ",color:"gray"},{score:{name:"#gen_rerolls",objective:"dr_var"}},{text:"   no way across: "},{score:{name:"#gen_fail_path",objective:"dr_var"}},{text:"   too little wood or iron: "},{score:{name:"#gen_fail_supply",objective:"dr_var"}},{text:"   gave up on: "},{score:{name:"#gen_failed",objective:"dr_var"}}]
tellraw @a [{text:"[gen] last section: ",color:"gray"},{score:{name:"#gen_wood",objective:"dr_var"}},{text:" wood seeds, "},{score:{name:"#gen_iron",objective:"dr_var"}},{text:" iron seeds, route "},{score:{name:"#gen_route",objective:"dr_var"}},{text:" tiles"}]
tellraw @a [{text:"[gen] last rivers: ",color:"gray"},{score:{name:"#riv_first",objective:"dr_var"}},{text:" and "},{score:{name:"#riv_second",objective:"dr_var"}},{text:" tiles, the second held to "},{score:{name:"#riv_need",objective:"dr_var"}}]
tellraw @a [{text:"[gen] last seam: ",color:"gray"},{score:{name:"#seam_rows",objective:"dr_var"}},{text:" of 16 rows carried over, as "},{score:{name:"#seam_n",objective:"dr_var"}},{text:" regions   notes found: "},{score:{name:"#seam_seen",objective:"dr_var"}},{text:", of those with a kind: "},{score:{name:"#seam_ok",objective:"dr_var"}},{text:"   waiting on a later wave: "},{score:{name:"#seam_late",objective:"dr_var"}},{text:", of those lost: "},{score:{name:"#seam_lost",objective:"dr_var"}}]
tellraw @a [{text:"[gen] the second river's search: ",color:"gray"},{score:{name:"#riv_dead",objective:"dr_var"}},{text:" tiles written off, "},{score:{name:"#riv_steps",objective:"dr_var"}},{text:" steps left, "},{score:{name:"#riv_tries",objective:"dr_var"}},{text:" starts left"}]
tellraw @a [{text:"[gen] rivers not laid at all: ",color:"gray"},{score:{name:"#gen_no_river",objective:"dr_var"}},{text:"   fell back to their longest: "},{score:{name:"#riv_fell",objective:"dr_var"}},{text:"   ending in a lake: "},{score:{name:"#riv_lakes",objective:"dr_var"}},{text:"   no region for a lake: "},{score:{name:"#riv_dry",objective:"dr_var"}},{text:"   second rivers ending in the first: "},{score:{name:"#riv_joins",objective:"dr_var"}},{text:"   loops cut out: "},{score:{name:"#riv_cuts",objective:"dr_var"}}]
