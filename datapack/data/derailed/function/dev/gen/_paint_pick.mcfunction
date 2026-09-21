
# Looks up the block region $(n) grew as and the one kind $(k) is drawn in

$data modify storage derailed:gen p.id set from storage derailed:gen ids[$(n)]
$data modify storage derailed:gen p.kind set from storage derailed:gen kinds[$(k)]
