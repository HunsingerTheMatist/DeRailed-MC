
# Opens the section up until the train is pinched no more than the tier allows,
#  a round at a time: a run of the first route lying against either end of it
#  is opened first where there is one, from that end, since a pinch there can
#  leave no way round the train at all, and otherwise the longest run, from
#  its exit end, each only as far as brings the section under its ceiling;
#  then the route is found again over what was opened, and the pinching
#  measured afresh
# Positioned at the section's corner

execute if function derailed:dev/gen/_pinch_round run function derailed:dev/gen/_pinch_relieve
