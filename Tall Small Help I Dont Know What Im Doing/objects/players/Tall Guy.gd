extends KinematicBody2D

export (int) var speed = 50
export (int) var jump_speed = -90
export (int) var gravity = 300
export var jumped = false

onready var timer = get_node("Jump Timer")

var velocity = Vector2()
var direction = "left"


onready var state_machine = $AnimationTree["parameters/playback"]

func _ready():
	timer.connect("timeout", self, "jump_timer")

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_speed
		timer.start()
	if is_on_floor() and jumped == true:
		jumped = false
		BigJump.bigJump()
		
	if velocity.x != 0 and is_on_floor():
		state_machine.travel("Walk")
	elif not is_on_floor():
		state_machine.travel("Fall")
	elif Input.is_action_just_pressed("ui_up") and is_on_floor():
		state_machine.travel("Jump")
		return
	elif Input.is_action_just_pressed("ui_down"):
		state_machine.travel("Kick")
	else:
		state_machine.travel("Idle")
	
	if velocity.x > 0:
		$tg_sprite.flip_h = true
	elif velocity.x < 0:
		$tg_sprite.flip_h = false

func jump_timer():
	jumped = true
