extends Area2D

export (NodePath) var player
export (NodePath) var player2
export (int) var current_level


func _process(delta):
	if overlaps_body(get_node(player)) or overlaps_body(get_node(player2)):
		LevelState.complete(current_level)
