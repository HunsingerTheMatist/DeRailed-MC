
# Cuts a river along the boundaries between regions, in from one border and out
#  by the other, and a second beside it when the first came up short, allowed to
#  end in the first
# Positioned at the section's corner

execute if function derailed:dev/gen/_rivers_a run function derailed:dev/gen/_rivers_b
