extends Area2D

@export var newScene = "main"

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(newScene + ".tscn")
