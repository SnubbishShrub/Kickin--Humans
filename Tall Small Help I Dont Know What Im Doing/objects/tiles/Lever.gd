extends Area2D

export var lever_id: int

var switched = false

onready var kickbox = get_node("../Tall Guy/Kickbox")

func _physics_process(delta):
	if overlaps_area(kickbox) and Input.is_action_just_pressed("ui_down"):
		if switched:
			DoorAutoload.emit_signal("lever_off", lever_id)
			switched = false
			$Sprite.frame = 0
		else:
			DoorAutoload.emit_signal("lever_on", lever_id)
			switched = true
			$Sprite.frame = 1
