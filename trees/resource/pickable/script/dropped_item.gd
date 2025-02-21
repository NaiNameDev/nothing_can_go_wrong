extends RigidBody3D

var orig_pickable: Pickable

var old_speed: Vector3
var gate: float = -30

func _process(delta: float) -> void:
	drop_sound()

func set_face(pick_me: Pickable):
	
	var msh = pick_me.model.instantiate()
	add_child(msh)
	orig_pickable = pick_me

func drop_sound():
	if old_speed.length() > (linear_velocity.length() + angular_velocity.length()) + 0.7:
		GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/down.wav", self, 0)
	old_speed = linear_velocity + angular_velocity
