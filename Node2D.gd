extends RigidBody2D

export var fall_speed = 200
export var player_knockback_force = 500

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	position.x = rand_range(0, screen_size.x)
	position.y = -50  # Začíná nad obrazovkou

func _physics_process(delta):
	# Pohyb dolů
	position.y += fall_speed * delta
	
	# Pokud meteorit opustí obrazovku, resetujeme jeho pozici
	if position.y > screen_size.y + 50:
		reset_position()

func _on_Meteor_body_entered(body):
	if body.is_in_group("player"):
		# Vypočítáme směr odhození
		var direction = (body.global_position - global_position).normalized()
		
		# Aplikujeme sílu na hráče
		body.apply_central_impulse(direction * player_knockback_force)
		
		# Resetujeme pozici meteoritu
		reset_position()

func reset_position():
	position.x = rand_range(0, screen_size.x)
	position.y = -50
