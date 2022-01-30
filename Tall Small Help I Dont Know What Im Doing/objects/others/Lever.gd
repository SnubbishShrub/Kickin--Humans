extends Node2D


export var state = "off"
export var red = true


# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "off":
		if red == true:
			$AnimationPlayer.play("Red Off")
		else:
			$AnimationPlayer.play("Blue Off")
	else:
		if red == true:
			$AnimationPlayer.play("Red On")
		else:
			$AnimationPlayer.play("Blue On")
		
func _process(_delta):
	if ($Area2D.overlaps_body($"../../../Tall Guy") and Input.is_action_just_pressed("ui_down")) or \
	($Area2D.overlaps_body($"../../../Small Guy") and Input.is_action_just_pressed("2_topple")):
		if state == "off":
			state = "on"
			if red == true:
				$AnimationPlayer.play("Red On")
			else:
				$AnimationPlayer.play("Blue On")
		else:
			state = "off"
			if red == true:
				$AnimationPlayer.play("Red Off")
			else:
				$AnimationPlayer.play("Blue Off")
		GlobalLever.LeverChanged()
