extends CharacterBody2D

const SPEED = 300.0
const BASE_JUMP_VELOCITY = -400.0
const MAX_JUMP_VELOCITY = -600.0  # 2x silnější než BASE_JUMP_VELOCITY
var GRAVITY = 980
var isClimbing = false

var time_left = 60  # 60 sekund na dosažení cíle
var is_charging_jump = false
var charge_time = 0.0
const MAX_CHARGE_TIME = 1.0  # Maximální čas nabíjení skoku

func is_on_floor_custom():
	return is_on_floor() or isClimbing

func _physics_process(delta):
	# Volitelně: Přidejte vizuální indikátor nabíjení skoku
	if is_charging_jump:
		var charge_percentage = (charge_time / MAX_CHARGE_TIME) * 100
		$"CanvasLayer/ProgressBar".value  = (int(charge_percentage))  
	# Přidání gravitace
	if not is_on_floor_custom():
		velocity.y += GRAVITY * delta

	# Ovládání skoku
	if Input.is_action_just_pressed("jump") and is_on_floor_custom():
		start_charge_jump()
	elif Input.is_action_pressed("jump") and is_charging_jump:
		continue_charge_jump(delta)
	elif Input.is_action_just_released("jump") and is_charging_jump:
		execute_jump()

	# Získání směru pohybu
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction > 0
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Aktualizace zbývajícího času
	time_left -= delta
	if time_left <= 0:
		#game_over()
		get_tree().quit()

func start_charge_jump():
	is_charging_jump = true
	charge_time = 0.0

func continue_charge_jump(delta):
	charge_time += delta
	charge_time = min(charge_time, MAX_CHARGE_TIME)

func execute_jump():
	var jump_power = lerp(BASE_JUMP_VELOCITY, MAX_JUMP_VELOCITY, charge_time / MAX_CHARGE_TIME)
	velocity.y = jump_power
	is_charging_jump = false
	charge_time = 0.0
