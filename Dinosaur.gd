extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_TIME = 0.3
const GRAVITY = 980

var jump_time = 0.0
var is_jumping = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_time = 0.0
		is_jumping = true
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("jump") and is_jumping:
		jump_time += delta
		if jump_time <= MAX_JUMP_TIME:
			velocity.y = JUMP_VELOCITY
		else:
			is_jumping = false
	elif Input.is_action_just_released("jump"):
		is_jumping = false

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
