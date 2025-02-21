extends "res://trees/station/forge/script/forge.gd"

@onready var anim: AnimationPlayer = $handler/AnimationPlayer

func tick():
	if works and electrocity:
		
		animaa()
		first_res_left -= first_res_per_second
		second_res_left -= second_res_per_second
		strength_left -= strength_per_second
		out_now += out_per_second
		
		update_info()
		if anim.is_playing() == false:
			anim.play("a1")
	else:
		if $AudioStreamPlayer3D.playing == true:
			$AudioStreamPlayer3D.stop()
		anim.stop()

func animaa():
	await $handler/AnimationPlayer.animation_finished
	await get_tree().create_timer(0.6).timeout
	if $AudioStreamPlayer3D.playing == false:
		$AudioStreamPlayer3D.play()
