extends Button

@export var newScene = preload("res://cutscena1.tscn")

func _pressed():
	get_tree().change_scene_to_packed(newScene)
