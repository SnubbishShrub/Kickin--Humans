extends Control


var paused = false

onready var level = get_tree()
onready var sprite = $"P Menu"
onready var resume = $"Resume"
onready var reset = $"Reset"
onready var menu = $"Menu"


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
			
	if resume.is_pressed():
		level.paused = false
		paused = false
		sprite.visible = false
		resume.disabled = true
		reset.disabled = true
		menu.disabled = true
		
	if reset.is_pressed():
		level.paused = false
		get_tree().reload_current_scene()
			
	if menu.is_pressed():
		get_tree().change_scene("res://levels/temp_menu.tscn")
	
	if resume.is_hovered():
		sprite.set_frame(1)
	elif reset.is_hovered():
		sprite.set_frame(2)
	elif menu.is_hovered():
		sprite.set_frame(3)
	else:
		sprite.set_frame(0)
		
