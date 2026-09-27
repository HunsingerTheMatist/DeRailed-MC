
# Marks every tile of the first route 'dr_cp', as the cheapest way across
# Positioned at the section's corner, with the routes drawn two above

data modify storage derailed:gen e.f set value "_water_path_at"
function derailed:dev/gen/_each
