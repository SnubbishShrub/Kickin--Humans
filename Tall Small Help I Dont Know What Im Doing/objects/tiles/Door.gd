extends TileMap

export var require_button: bool
export var require_lever: bool
export var required_button_id: int
export var required_lever_id: int

var required_button_pressed = false
var required_lever_switched = false

func _ready():
	DoorAutoload.connect("button_pressed", self, "_button_pressed")
	DoorAutoload.connect("button_released", self, "_button_released")
	DoorAutoload.connect("lever_on", self, "_lever_on")
	DoorAutoload.connect("lever_off", self, "_lever_off")

func _button_pressed(button_id):
	if button_id == required_button_id:
		required_button_pressed = true

func _button_released(button_id):
	if button_id == required_button_id:
		required_button_pressed = false

func _lever_on(lever_id):
	if lever_id == required_lever_id:
		required_lever_switched = true

func _lever_off(lever_id):
	if lever_id == required_lever_id:
		required_lever_switched = false

func _physics_process(delta):
	if ((required_button_pressed and require_button) or not require_button) and ((required_lever_switched and require_lever) or not require_lever):
		visible = false
		collision_layer = 8
		collision_mask = 8
	else:
		visible = true
		collision_layer = 1
		collision_mask = 1
