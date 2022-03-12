extends Camera2D


export var decay = 0.8 
export var max_offset = Vector2(100, 75) 
export var max_roll = 0.1 
export (NodePath) var center  

var trauma = 0.0 
var trauma_power = 2 
var noise_y = 0

onready var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	BigJump.connect("bigJump", self, "add_trauma")
	KickAndBreak.connect("Kicked", self, "add_trauma")
	KickAndBreak.connect("Break", self, "add_trauma")
	center = get_node(center)
	

	
func add_trauma(num):
	trauma = min(trauma + num, 1.0)
	
func _process(delta):
	global_position = center.global_position
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
