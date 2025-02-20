extends Node3D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://trees/level/level/scene/level.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://trees/level/test_level/scene/test_level.tscn")
