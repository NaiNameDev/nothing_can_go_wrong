extends "res://trees/station/forge/script/forge.gd"

@onready var anim: AnimationPlayer = $handler/AnimationPlayer

func tick():
	if works and electrocity:
		first_res_left -= first_res_per_second
		second_res_left -= second_res_per_second
		strength_left -= strength_per_second
		out_now += out_per_second
		
		update_info()
		if anim.is_playing() == false:
			anim.play("a1")
	else:
		anim.stop()
