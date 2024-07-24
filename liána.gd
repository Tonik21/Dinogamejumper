extends Area2D

var climb_speed = 1000
var player = null

func _physics_process(delta):
	if player and Input.is_action_pressed("ui_up"):
		player.position.y -= climb_speed * delta
	elif player and Input.is_action_pressed("ui_down"):
		player.position.y += climb_speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		print(body)
		player = body

func _on_body_exited(body):
	if body == player:
		player = null
