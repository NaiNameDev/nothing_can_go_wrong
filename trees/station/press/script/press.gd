extends "res://trees/station/forge/script/forge.gd"

@export var press_animation1: AnimationPlayer
@export var drop_place2: Node3D

func tick():
	if works and electrocity:
		audio()
		first_res_left -= first_res_per_second
		second_res_left -= second_res_per_second
		strength_left -= strength_per_second
		out_now += out_per_second
		if !press_animation1.is_playing():
			press_animation1.play("a1")
		
		update_info()
	else:
		if $AudioStreamPlayer3D.playing == true:
			$AudioStreamPlayer3D.stop()
		if $AudioStreamPlayer3D2.playing == true:
			$AudioStreamPlayer3D.stop()
		press_animation1.stop()

func on_out_set(v):
	out_now = v
	
	if out_now > out_max and drop_place:
		GlobalFunctions.drop_item(drop_place.global_position, drop_place2.global_position, out)
		done.emit()
		out_now = 0

func audio():
	await $press/AnimationPlayer1.animation_finished
	await get_tree().create_timer(1.6).timeout
	if randi_range(0,1) == 1 and $AudioStreamPlayer3D.playing == false and $AudioStreamPlayer3D2.playing == false:
		$AudioStreamPlayer3D.play()
	else:
		$AudioStreamPlayer3D.play()
