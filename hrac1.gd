extends CharacterBody2D

const SPEED = 200.0
const BASE_JUMP_VELOCITY = -200.0
const MAX_JUMP_VELOCITY = -400.0  # 2x silnější než BASE_JUMP_VELOCITY
var GRAVITY = 980
const NORMAL_FRICTION = 1.0
const ICE_FRICTION = 0.75  # 4x menší tření
var isClimbing = false

var time_left = 60  # 60 sekund na dosažení cíle
var is_charging_jump = false
var charge_time = 0.0
const MAX_CHARGE_TIME = 1.0  # Maximální čas nabíjení skoku
var current_friction = NORMAL_FRICTION

@onready var tilemap: TileMap = get_parent(). get_node("TileMap")

func is_on_floor_custom():
	return is_on_floor() or isClimbing

func set_ice_friction():
	current_friction = ICE_FRICTION
	
func check_icy_tile():
	if is_on_floor_custom():
		var tile_pos = tilemap.local_to_map(global_position/3)
		var tile_pos_under = tilemap.local_to_map(global_position/3)
		tile_pos_under.y += 1
		var tile_data = tilemap.get_cell_tile_data(0, tile_pos)
		var tile_data_under = tilemap.get_cell_tile_data(0, tile_pos_under)
		if (tile_data and tile_data.get_custom_data("is_icy")) or (tile_data_under and tile_data_under.get_custom_data("is_icy")):
			current_friction = ICE_FRICTION
			floor_max_angle = deg_to_rad(10)
		else:
			floor_max_angle = deg_to_rad(45)

func _physics_process(delta):
	# Volitelně: Přidejte vizuální indikátor nabíjení skoku
	if is_charging_jump:
		var charge_percentage = (charge_time / MAX_CHARGE_TIME) * 100
		$"CanvasLayer/ProgressBar".value  = (int(charge_percentage))  
	# Přidání gravitace
	if not is_on_floor_custom():
		velocity.y += GRAVITY * delta
		

	check_icy_tile()

	# Aplikace tření
	print(current_friction)
	velocity.x *= 1/current_friction

	move_and_slide()

	# Po pohybu resetujeme tření na normální hodnotu
	current_friction = NORMAL_FRICTION
	

	


	# Zbytek kódu zůstává stejný...

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
