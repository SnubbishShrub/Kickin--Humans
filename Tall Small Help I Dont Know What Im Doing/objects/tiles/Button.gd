extends Area2D

export var button_id: int

var pressed = false

func press_button():
	DoorAutoload.emit_signal("button_pressed", button_id)

func release_button():
	DoorAutoload.emit_signal("button_released", button_id)

func _on_Button_body_entered(body):
	if not pressed:
		pressed = true
		press_button()
		$Sprite.frame = 1


func _on_Button_body_exited(body):
	pressed = false
	release_button()
	$Sprite.frame = 0
