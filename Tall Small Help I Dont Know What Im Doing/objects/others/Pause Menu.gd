extends Control


var paused = false

onready var level = get_tree()
onready var sprite = $"P Menu"
onready var resume = $"Resume"
onready var reset = $"Reset"
onready var menu = $"Menu"
onready var pos = $"P Menu".position


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if paused == false:
			level.paused = true
			paused = true
			sprite.visible = true
			resume.disabled = false
			reset.disabled = false
			menu.disabled = false
		elif paused == true:
			level.paused = false
			paused = false
			sprite.visible = false
			resume.disabled = true
			reset.disabled = true
			menu.disabled = true
	
	if resume.is_hovered():
		sprite.set_frame(1)
	elif reset.is_hovered():
		sprite.set_frame(2)
	elif menu.is_hovered():
		sprite.set_frame(3)
	else:
		sprite.set_frame(0)
		

func _on_Resume_pressed():
	level.paused = false
	paused = false
	sprite.visible = false
	resume.disabled = true
	reset.disabled = true
	menu.disabled = true

func _on_Reset_pressed():
	level.paused = false
	SceneChange.scene_change(get_tree().current_scene.filename, pos)

func _on_Menu_pressed():
	level.paused = false
	SceneChange.scene_change("res://levels/temp_menu.tscn", pos)
