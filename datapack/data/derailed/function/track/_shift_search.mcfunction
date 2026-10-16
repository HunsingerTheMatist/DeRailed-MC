# Puts the items down near here, and removes this throwaway marker
# Run as the throwaway marker
#
# Returns 1 when they all went down, fail otherwise

execute if function derailed:item/place_near run return run kill @s
kill @s
return fail
