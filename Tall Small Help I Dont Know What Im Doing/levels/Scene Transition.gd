extends Node

export (NodePath) var start

func _ready():
	$Sprite.global_position = get_node(start).global_position
	$Sprite.set_frame(0)
	$AnimationPlayer.play("Open")
	SceneChange.connect("scene_change", self, "close")
	get_tree().paused = false


func close(scene, pos):
	$Sprite.position = pos
	$AnimationPlayer.play("Close")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(scene)
	
