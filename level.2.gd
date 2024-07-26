extends Area2D

@export var newScene = preload("res://prvni_bajom_a_frame.tscn")

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_packed(newScene)
