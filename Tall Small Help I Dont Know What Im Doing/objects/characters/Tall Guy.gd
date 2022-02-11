extends KinematicBody2D

export (int) var speed = 50
export (int) var jump_speed = -110
export (int) var gravity = 300

var velocity = Vector2()
var on_ground = true
var can_move = true

onready var state_machine = $AnimationTree["parameters/playback"]
onready var timer = get_node("Move Timer")


func _ready():
	timer.connect("timeout", self, "move_timer")


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Prevent movement after boom
	if can_move == true:
		get_input()
	
	# Vert Movement
	velocity.y += gravity * delta
		
	# Big Landing
	if not is_on_floor():
		on_ground = false
	if is_on_floor() and on_ground == false:
		velocity.x = 0
		can_move = false
		timer.start()
		on_ground = true
		BigJump.bigJump()
		$"Bang".play_random()

	# Visuals
	# Animation
	if Input.is_action_just_pressed("ui_down"):
		state_machine.travel("Kick")
	elif Input.is_action_just_pressed("ui_up") and is_on_floor() and can_move == true:
		state_machine.travel("Jump")
	elif velocity.x != 0 and is_on_floor():
		state_machine.travel("Walk")
	elif not is_on_floor():
		state_machine.travel("Fall")
	else:
		state_machine.travel("Idle")
	
	# Orientation
	if velocity.x > 0:
		$tg_sprite.flip_h = true
		$Kickbox.position.x = 8
	elif velocity.x < 0:
		$tg_sprite.flip_h = false
		$Kickbox.position.x = -8

# Allow player to move again
func move_timer():
	can_move = true

# L/R Movement
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		
func jump():
	velocity.y = jump_speed
