extends Control

export (NodePath) var camera

var paused = false
var complete = false

onready var level = get_tree()
onready var sprite = $"P Menu"
onready var resume = $"Resume"
onready var reset = $"Reset"
onready var menu = $"Menu"

func _ready():
	LevelState.connect("complete", self, "stop")

func _process(_delta):
	if complete == true:
		return
		
	rect_global_position = get_node(camera).global_position
	rect_scale = get_node(camera).zoom
	
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
		
func stop(lev):
	complete = true
	lev = lev

func _on_Resume_pressed():
	level.paused = false
	paused = false
	sprite.visible = false
	resume.disabled = true
	reset.disabled = true
	menu.disabled = true

func _on_Reset_pressed():
	level.paused = false
	SceneChange.scene_change(get_tree().current_scene.filename, rect_global_position)

func _on_Menu_pressed():
	level.paused = false
	SceneChange.scene_change("res://levels/levels.tscn", rect_global_position)
