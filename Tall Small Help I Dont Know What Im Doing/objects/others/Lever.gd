extends Node2D


export var state = "off"


# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "off":
		$"Lever Sprite".flip_h = false
	else:
		$"Lever Sprite".flip_h = true
		
func _process(_delta):
	if ($Area2D.overlaps_body($"../../../Tall Guy") and Input.is_action_just_pressed("ui_down")) or \
	($Area2D.overlaps_body($"../../../Small Guy") and Input.is_action_just_pressed("2_topple")):
		if state == "off":
			state = "on"
		else:
			state = "off"
		GlobalLever.LeverChanged()
	if state == "off":
		$"Lever Sprite".flip_h = false
	else:
		$"Lever Sprite".flip_h = true
