extends KinematicBody2D

export (int) var speed = 150
export (int) var max_speed = 450
export (int) var jump_speed = -800
export (int) var gravity = 2500
export (int) var wall_gravity = 100
export (int) var wall_jump_speed_x = 3000
export (int) var wall_jump_speed_y = -600
export (float) var friction = 0.7
export (float) var max_friction = 0.4
export (int) var max_wall_speed = 300
export (int) var kick_x = 10000
export (int) var kick_y = -1200

var velocity = Vector2()
var kicked = false
var kick_time = 1
onready var kickbox = get_node("../Tall Guy/Kickbox")

func _ready():
	print(kickbox)

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
	if $"Hurtbox".overlaps_area(kickbox) and Input.is_action_just_pressed("ui_down"):
		kickHit()
	kick_time -= delta
	if kick_time <= 0:
		kick_time = 1
		kicked = false
	get_input()
	velocity = move_and_slide(velocity, Vector2.UP)
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

func kickHit():
	kicked = true
	if $"Hurtbox/Left Raycast2".is_colliding():
		velocity.x = kick_x
		velocity.y = kick_y
	elif $"Hurtbox/Right Raycast2".is_colliding():
		velocity.x = -kick_x
		velocity.y = kick_y
