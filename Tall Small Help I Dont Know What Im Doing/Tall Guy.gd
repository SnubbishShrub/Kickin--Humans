extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -600
export (int) var gravity = 3000
export var jumped = false

var velocity = Vector2()
var direction = "left"
onready var timer = get_node("Jump Timer")

func _ready():
	timer.connect("timeout", self, "jump_timer")

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("ui_right") and direction == "left":
		scale.x = -1
		direction = "right"
	if Input.is_action_just_pressed("ui_left") and direction == "right":
		scale.x = -1
		direction = "left"
		
		
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

func jump_timer():
	jumped = true
