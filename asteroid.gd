extends RigidBody2D

var knockback_force = 800

var originalPositon = Vector2.ZERO

func _ready():
	$AnimationPlayer.play("fly")
	randomize()
	originalPositon = position

func _physics_process(delta):
	
	var collision = move_and_collide(Vector2.ZERO)
	
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("player"):
			var direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
			print(direction)
			collider.knockback(direction * knockback_force)
			#queue_free()
		position = originalPositon
		linear_velocity = Vector2.ZERO

	




