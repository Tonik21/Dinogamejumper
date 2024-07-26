extends Node2D

@export var newScene = preload("res://prvni_bajom_a_frame.tscn")

func _on_video_stream_player_finished():
	get_tree().change_scene_to_packed(newScene)
