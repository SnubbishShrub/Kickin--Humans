extends KinematicBody2D

export var controllable = false
export var req_lever_id: int
export (float) var wait = 1

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
		
func switch(lever_id):
	if lever_id == req_lever_id and not fired:
		fire()
		
func reset():
	fired = false
		
func fire():
	print("pow")
	if not controllable:
		auto.start()
	else:
		fired = true
		cooldown.start()
		

	
