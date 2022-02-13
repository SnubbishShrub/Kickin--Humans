extends StaticBody2D

func _on_breaking_area_body_entered(body):
	if body.get("kicked"):
		queue_free()
