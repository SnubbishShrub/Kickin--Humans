extends Node2D


export var state = "off"
export var red = true

func _ready():
	pass
		
func _process(_delta):
	if $Area2D.overlaps_body($"../../../Tall Guy") or $Area2D.overlaps_body($"../../../Small Guy"):
		state = "on"
		if red == true:
			$AnimationPlayer.play("On Red")
		else:
			$AnimationPlayer.play("On Blue")
	else:
		state = "off"
		if red == true:
			$AnimationPlayer.play("Off Red")
		else:
			$AnimationPlayer.play("Off Blue")
	GlobalLever.ButtonState()
	
	if state == "off":
		pass 
	else:
		pass 
