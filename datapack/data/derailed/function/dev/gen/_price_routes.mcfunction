
# Adds up what each route costs to lay into '#price_first' and '#price_second',
#  every tile after the one the track comes in on
# Positioned at the section's corner, with the routes drawn two above

data modify storage derailed:gen e.f set value "_price_at"
function derailed:dev/gen/_each
function derailed:dev/gen/_price_entry with storage derailed:gen r
