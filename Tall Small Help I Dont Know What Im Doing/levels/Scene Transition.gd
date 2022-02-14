extends Node


func _ready():
	$Sprite.set_frame(0)
	$AnimationPlayer.play("Open")
	SceneChange.connect("scene_change", self, "close")


func close(scene, pos):
	$Sprite.position = pos
	print(scene)
	$AnimationPlayer.play("Close")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene(scene)
	
