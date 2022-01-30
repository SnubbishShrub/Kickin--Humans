extends KinematicBody2D

export (int) var speed = 40
export (int) var max_speed = 150
export (int) var jump_speed = -150
export (int) var gravity = 600
export (int) var wall_gravity = 10
export (int) var wall_jump_speed_x = 500
export (int) var wall_jump_speed_y = -150
export (float) var friction = 0.7
export (float) var max_friction = 0.4
export (int) var max_wall_speed = 50
export (int) var kick_x = 2000
export (int) var kick_y = -200

var velocity = Vector2()
var kicked = false
var kick_time = 1
var direction = "right"
onready var kickbox = get_node("../Tall Guy/Kickbox")
onready var state_machine = $AnimationTree["parameters/playback"]

func get_input():
	velocity.x *= friction
	if Input.is_action_pressed("2_right"):
		velocity.x += speed
		if velocity.x > max_speed:
			velocity.x *= max_friction
	if Input.is_action_pressed("2_left"):
		velocity.x -= speed
		if velocity.x < -max_speed:
			velocity.x *= max_friction

func _physics_process(delta):
	if $Hurtbox.overlaps_area(kickbox) and Input.is_action_just_pressed("ui_down"):
		kickHit()
	kick_time -= delta
	if kick_time <= 0:
		kick_time = 1
		kicked = false
	get_input()
	if velocity.x > 0:
		$lg_sprite.flip_h = false
	elif velocity.x < 0:
		$lg_sprite.flip_h = true
	if velocity.x < 1 and velocity.x > -1:
		velocity.x = 0
	if is_on_wall():
		velocity.y += wall_gravity
		if velocity.y > max_wall_speed:
			velocity.y = max_wall_speed
	else:
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("2_up"):
		if is_on_floor():
			velocity.y = jump_speed
		elif $"Left Raycast".is_colliding():
			if Input.is_action_pressed("2_left"):
				print("less")
				velocity.y = 0.4 * wall_jump_speed_y
				velocity.x = wall_jump_speed_x
			elif Input.is_action_pressed("2_right"):
				print("more")
				velocity.y = 1.2 * wall_jump_speed_y
				velocity.x = wall_jump_speed_x
			else:
				print("normal")
				velocity.y = wall_jump_speed_y
				velocity.x = wall_jump_speed_x
		elif $"Right Raycast".is_colliding():
			if Input.is_action_pressed("2_right"):
				print("less")
				velocity.y = 0.4 * wall_jump_speed_y
				velocity.x = -wall_jump_speed_x
			elif Input.is_action_pressed("2_left"):
				print("more")
				velocity.y = 1.2 * wall_jump_speed_y
				velocity.x = -wall_jump_speed_x
			else:
				print("normal")
				velocity.y = wall_jump_speed_y
				velocity.x = -wall_jump_speed_x
	velocity = move_and_slide(velocity, Vector2.UP)
	state_machine.travel("Idle")
	if kicked == true:
		state_machine.travel("Ball")
		return
	elif velocity.x != 0 and is_on_floor():
		state_machine.travel("Walk")
	elif not is_on_floor():
		state_machine.travel("Fall")
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		state_machine.travel("Jump")
		return
	elif ($"Left Raycast".is_colliding() or $"Right Raycast".is_colliding()) and \
	not is_on_floor():
		state_machine.travel("Slide")

func kickHit():
	kicked = true
	if $"Hurtbox/Left Raycast".is_colliding():
		velocity.x = -kick_x
		velocity.y = kick_y
		print("left")
	elif $"Hurtbox/Right Raycast".is_colliding():
		velocity.x = kick_x
		velocity.y = kick_y
		print("right")
