extends KinematicBody2D

export var controllable = false
export var req_lever_id: int
export (float) var wait = 1 # Note: must be 1 or greater
export (String, "up", "down", "left", "right") var direction

var fired = false

onready var auto = $"Auto"
onready var cooldown = $"Cooldown"

func _ready():
	if controllable:
		DoorAutoload.connect("lever_on", self, "switch")
		DoorAutoload.connect("lever_off", self, "switch")
		cooldown.connect("timeout", self, "reset")
	else:
		auto.set_wait_time(wait)
		auto.connect("timeout", self, "fire")
		auto.start()
	$AnimationPlayer.play("Stopped")

func switch(lever_id):
	if lever_id == req_lever_id and not fired:
		fire()
		
func reset():
	fired = false
		
func fire():
	$"AnimationPlayer".play("Kick")
	if not controllable:
		auto.start()
	else:
		fired = true
		cooldown.start()
		
func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "Small Guy":
		body.launch(direction)
	
	
