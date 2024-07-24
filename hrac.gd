extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 980

var time_left = 60  # 60 sekund na dosažení cíle

func _physics_process(delta):
	# Přidání gravitace
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Ovládání skoku
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Získání směru pohybu
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Aktualizace zbývajícího času
	time_left -= delta
	if time_left <= 0:
		game_over()

func game_over():
	# Implementace konce hry
	print("Game Over!")
	# Zde můžete přidat logiku pro restart hry nebo návrat do menu
