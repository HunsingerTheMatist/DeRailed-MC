
# Builds what 'dev/gen/test' builds, with what is only there to be looked at left
#  out of it
# Meant to be run from a command block every tick with the profiler going, so the
#  ten seconds it covers come out as a few hundred whole maps rather than one

# The stands are a dev view and a summon apiece, so a run timed with them on says
#  more about them than about the section they stand over, and the report is a
#  handful of lines of chat that nobody is reading at this rate
scoreboard players set #gen_marks dr_var 0
scoreboard players set #gen_report dr_var 0

function derailed:dev/gen/test

scoreboard players set #gen_marks dr_var 1
scoreboard players set #gen_report dr_var 1
