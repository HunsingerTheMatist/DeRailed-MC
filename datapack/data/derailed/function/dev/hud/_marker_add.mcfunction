
# Adds an arrow to the picture: across $(x) half map pixels, arrow glyph $(c),
#  its row of half map pixels times sixteen plus its way, in colour $(n), then
#  back to where it started so every arrow is placed from the board's corner

$data modify storage derailed:hud content.extra append from storage derailed:hud fwd[$(x)]
$data modify storage derailed:hud content.extra append from storage derailed:hud mark[$(c)]
$data modify storage derailed:hud content.extra[-1].color set from storage derailed:hud colors[$(n)]
$data modify storage derailed:hud content.extra append from storage derailed:hud back[$(x)]
