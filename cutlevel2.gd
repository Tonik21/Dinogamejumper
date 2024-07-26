extends Node2D

@export var newScene = preload("res://biom_2.tscn")

func _on_video_stream_player_finished():
	get_tree().change_scene_to_packed(newScene)
