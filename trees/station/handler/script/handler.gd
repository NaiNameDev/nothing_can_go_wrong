extends "res://trees/station/forge/script/forge.gd"

func tick():
	if works:
		first_res_left -= first_res_per_second
		second_res_left -= second_res_per_second
		strength_left -= strength_per_second
		out_now += out_per_second
		
		update_info()
