extends KinematicBody2D


export (int) var jump_speed = -200
export (int) var grav = 400
export (NodePath) var guy

var velocity = Vector2()
var jumped = false

onready var state_machine = $AnimationTree["parameters/playback"]

func _ready():
	BigJump.connect("bigJump", self, "jump")
	
func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += grav * delta
	
	if not is_on_floor():
		state_machine.travel("Jump")
	elif is_on_floor() and jumped == true:
		state_machine.travel("Land")
		jumped = false
	else:
		state_machine.travel("Idle")
		
func _process(_delta):
	if $"Area2D".overlaps_body(get_node(guy)):
		get_tree().reload_current_scene()
	
func jump():
	velocity.y = jump_speed
	jumped = true

