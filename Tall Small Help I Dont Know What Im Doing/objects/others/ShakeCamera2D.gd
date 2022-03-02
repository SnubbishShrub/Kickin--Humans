extends Camera2D


export var decay = 0.8 
export var max_offset = Vector2(100, 75) 
export var max_roll = 0.1 
export (NodePath) var small_guy
export (NodePath) var tall_guy    

var trauma = 0.0 
var trauma_power = 2 
var noise_y = 0
var distance_y
var distance_x
var zoom_factor

onready var noise = OpenSimplexNoise.new()

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	BigJump.connect("bigJump", self, "add_trauma")
	KickAndBreak.connect("Kicked", self, "add_trauma")
	KickAndBreak.connect("Break", self, "add_trauma")
	
	small_guy = get_node(small_guy)
	tall_guy = get_node(tall_guy)
	
func add_trauma(num):
	trauma = min(trauma + num, 1.0)
	
func _process(delta):
	global_position = small_guy.global_position
	global_position.y = global_position.y - 50
	distance_y = abs(tall_guy.position.y - small_guy.position.y)
	distance_x = abs(tall_guy.position.x - small_guy.position.x)
	
	if distance_x >= 200:
		zoom_factor = 1 + (0.004 * (distance_x - 199))
	elif distance_y >= 100:
		zoom_factor = 1 + (0.004 * (distance_y - 99))
	else:
		zoom_factor = 1
		
	zoom = Vector2(zoom_factor, zoom_factor)
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
