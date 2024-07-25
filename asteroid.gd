extends RigidBody2D

var fall_speed
var player_knockback_force
var screen_size

func _ready():
	fall_speed = 200
	player_knockback_force = 100000000
	screen_size = get_viewport_rect().size

 # Začíná nad obrazovkou

func _physics_process(delta):
	# Pohyb dolů
	position.y += fall_speed * delta
	
	# Pokud meteorit opustí obrazovku, resetujeme jeho pozici


func _on_Meteor_body_entered(body):
	if body.is_in_group("player"):
		# Vypočítáme směr odhození
		var direction = (body.global_position - global_position).normalized()
		
		# Aplikujeme sílu na hráče
		body.apply_central_impulse(direction * player_knockback_force)
		
		# Resetujeme pozici meteoritu




