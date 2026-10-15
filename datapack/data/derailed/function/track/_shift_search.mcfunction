# Puts the items down round here, and removes this throwaway marker
# Run as the throwaway marker
#
# Returns 1 when they went down, fail otherwise

execute if function derailed:item/try_place_around run return run kill @s
kill @s
return fail
