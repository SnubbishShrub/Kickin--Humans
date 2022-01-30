extends KinematicBody2D

export (int) var jump_speed = -400
export (int) var gravity = 1000

var velocity = Vector2()

func _ready():
	BigJump.connect("bigJump", self, "jump")

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
func jump():
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		velocity.y = jump_speed
