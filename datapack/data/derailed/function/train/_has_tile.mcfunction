# Returns 1 where team $(team)'s path has a tile $(i), fail otherwise

$return run execute if data storage derailed:train t$(team).path[$(i)]
