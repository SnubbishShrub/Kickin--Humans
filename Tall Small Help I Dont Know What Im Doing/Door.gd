extends Node2D

export var lever_key = "on"
export var button_key = "on"
var lever_comb = ""
var button_comb = ""
var levers = []
var buttons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	levers = get_node("Levers").get_children()
	buttons = get_node("Buttons").get_children()
	GlobalLever.connect("LeverChanged", self, "CheckKey")
	GlobalLever.connect("ButtonState", self, "CheckKey")

func CheckKey():
	var lever_comb = ""
	var button_comb = ""
	for lever in levers:
		lever_comb += lever.state
	for button in buttons:
		button_comb += button.state

	if (lever_key == lever_comb) and (button_key == button_comb):
		$"StaticBody2D/CollisionShape2D".disabled = true
	else:
		$"StaticBody2D/CollisionShape2D".disabled = false
