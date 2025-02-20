extends Node3D

var can: bool = true

func _on_to_open_body_entered(body: Node3D) -> void:
	if can:
		$kapsula/AnimationPlayer.play("up")

func _on_to_open_body_exited(body: Node3D) -> void:
	if can:
		$kapsula/AnimationPlayer.play_backwards("up")

func _on_inside_body_entered(body: Node3D) -> void:
	if EventBus.dayend == true and can and !EventBus.generator_state:
		$kapsula/AnimationPlayer.play_backwards("up")
		EventBus.start_new_day.emit()
		can = false
		print(GlobalVariables.gl_day_counter)
		if GlobalVariables.gl_day_counter > 3:
			EventBus.end_game.emit()
