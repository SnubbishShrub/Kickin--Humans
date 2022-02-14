extends Node


signal scene_change

func scene_change(scene, pos):
	emit_signal("scene_change", scene, pos)
