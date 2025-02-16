extends RigidBody3D

var orig_pickable: Pickable

func set_face(pick_me: Pickable):
	var msh = pick_me.model.instantiate()
	add_child(msh)
	orig_pickable = pick_me
