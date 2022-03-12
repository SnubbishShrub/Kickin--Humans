extends Control

export (NodePath) var camera

var current_level

onready var level = get_tree()
onready var sprite = $"Sprite"
onready var next = $"Next"
onready var reset = $"Reset"
onready var menu = $"Menu"
onready var pos = $"Sprite".global_position

func _ready():
	level.paused = false
	LevelState.connect("complete", self, "pop_up")
	
func _process(_delta):
	rect_global_position = get_node(camera).global_position
	rect_scale = get_node(camera).zoom
	#if next.is_hovered():
		#sprite.set_frame(1)
	#elif reset.is_hovered():
		#sprite.set_frame(2)
	#elif menu.is_hovered():
		#sprite.set_frame(3)
	#else:
		#sprite.set_frame(0)
		
func pop_up(lev):
	level.paused = true
	sprite.visible = true
	next.disabled = false
	reset.disabled = false
	menu.disabled = false
	current_level = lev

func _on_Next_pressed():
	SceneChange.scene_change("res://levels/Level_" + str(current_level + 1) + ".tscn", pos)

func _on_Reset_pressed():
	SceneChange.scene_change(get_tree().current_scene.filename, pos)

func _on_Menu_pressed():
	SceneChange.scene_change("res://levels/levels.tscn", pos)
