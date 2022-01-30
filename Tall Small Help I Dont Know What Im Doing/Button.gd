extends Node2D


export var state = "off"


func _ready():
	pass
		
func _process(_delta):
	if $Area2D.overlaps_body($"../../../Tall Guy") or $Area2D.overlaps_body($"../../../Small Guy"):
		state = "on"
	else:
		state = "off"
	GlobalLever.ButtonState()
	
	if state == "off":
		pass 
	else:
		pass 
