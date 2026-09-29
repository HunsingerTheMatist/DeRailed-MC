# Builds what 'dev/gen/test' builds once for every seed in 'prof.seeds', each
#  moved on by '#prof_base', with what is only there to be looked at left out
#  of it
# Meant to be run from a command block every tick with the profiler going:
#  every tick builds the same maps, so whatever whole ticks the profiler takes
#  time the same work, however it was started

# The stands are a dev view and a summon apiece, so a run timed with them on says
#  more about them than about the section they stand over, and the report is a
#  handful of lines of chat that nobody is reading at this rate
scoreboard players set #gen_marks dr_var 0
scoreboard players set #gen_report dr_var 0

data modify storage derailed:gen prof.left set from storage derailed:gen prof.seeds
function derailed:dev/gen/_profile_map

scoreboard players set #gen_marks dr_var 1
scoreboard players set #gen_report dr_var 1
