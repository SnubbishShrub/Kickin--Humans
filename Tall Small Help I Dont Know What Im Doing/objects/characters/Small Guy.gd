extends KinematicBody2D

export (int) var speed = 40
export (int) var max_speed = 150
export (int) var jump_speed = -150
export (int) var gravity = 600
export (int) var wall_gravity = 10
export (int) var max_wall_speed = 50
export (int) var wall_jump_speed_x = 650
export (int) var wall_jump_speed_y = -180
export (float) var friction = 0.7
export (float) var max_friction = 0.4
export (int) var kick_x = 2000
export (int) var kick_y = -200
export (int) var boot = 3000

var velocity = Vector2()
var kicked = false

onready var kickbox = get_node("../Tall Guy/Kickbox")
onready var state_machine = $AnimationTree["parameters/playback"]
onready var timer = get_node("Kicked Timer")

func _ready():
	timer.connect("timeout", self, "unkick")

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Kick
	if $Hurtbox.overlaps_area(kickbox) and Input.is_action_just_pressed("ui_down"):
		kickHit()
		$"Kicked".play_random()
		
	# L/R Movement
	get_input()
	
	# Bring player to complete stop
	if velocity.x < 1 and velocity.x > -1:
		velocity.x = 0
		
	# Wall Slide
	if is_on_wall():
		velocity.y += wall_gravity
		if velocity.y > max_wall_speed:
			velocity.y = max_wall_speed
	else:
		velocity.y += gravity * delta
		
	# Jump
	if Input.is_action_just_pressed("sg_up"):
		if is_on_floor():
			velocity.y = jump_speed
		
		# Wall Jump
		elif $"Left Raycast".is_colliding() and not Input.is_action_pressed("sg_left"):
				velocity.y = wall_jump_speed_y
				velocity.x = wall_jump_speed_x
		elif $"Right Raycast".is_colliding() and not Input.is_action_pressed("sg_right"):
				velocity.y = wall_jump_speed_y
				velocity.x = -wall_jump_speed_x
				
	
	# VISUALS
	# Orientation
	if velocity.x > 0:
		$lg_sprite.flip_h = false
	elif velocity.x < 0:
		$lg_sprite.flip_h = true
	# Animation
	state_machine.travel("Idle")
	if kicked == true:
		state_machine.travel("Ball")
	elif velocity.x != 0 and is_on_floor():
		state_machine.travel("Walk")
	elif not is_on_floor():
		state_machine.travel("Fall")
	if Input.is_action_just_pressed("sg_up") and is_on_floor():
		state_machine.travel("Jump")
	elif ($"Left Raycast".is_colliding() or $"Right Raycast".is_colliding()) and \
	not is_on_floor():
		state_machine.travel("Slide")

# Kicked
func kickHit():
	kicked = true
	timer.start()
	KickAndBreak.Kicked()
	if $"Hurtbox/Left Raycast".is_colliding():
		velocity.x = -kick_x
		velocity.y = kick_y
	elif $"Hurtbox/Right Raycast".is_colliding():
		velocity.x = kick_x
		velocity.y = kick_y
		
# Undo effect of kick
func unkick():
	kicked = false
		
# Left/Right Movement
func get_input():
	velocity.x *= friction
	if Input.is_action_pressed("sg_right"):
		velocity.x += speed
		if velocity.x > max_speed:
			velocity.x *= max_friction
	if Input.is_action_pressed("sg_left"):
		velocity.x -= speed
		if velocity.x < -max_speed:
			velocity.x *= max_friction

func launch(direction):
	print("pow")
	if direction == "up":
		velocity.y = -boot
	elif direction == "down":
		velocity.y = boot
	elif direction == "right":
		velocity.x = boot
	else:
		velocity.x = -boot
