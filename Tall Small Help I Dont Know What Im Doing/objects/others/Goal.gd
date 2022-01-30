extends Area2D

export (NodePath) var player
export (NodePath) var player2
export (String, FILE) var next_level

func _process(delta):
	if overlaps_body(get_node(player)) or overlaps_body(get_node(player2)):
		get_tree().change_scene(next_level)
