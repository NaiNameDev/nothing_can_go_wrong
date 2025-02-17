extends MeshInstance3D

@export var frg: Node3D
@export var prs: Node3D
@export var hnd: Node3D

func _ready() -> void:
	EventBus.connect("update_info", update_info)

func update_info(type: String, id: int, res1: float, res2: float, res3: float, works: bool):
	match type:
		"forge":
			frg.get_child(id).text = type + " " + str(id)
			if works:
				frg.get_child(id).modulate = Color(0,1,0)
			else:
				frg.get_child(id).modulate = Color(1,0,0)
		"press":
			prs.get_child(id).text = type + " " + str(id)
			if works:
				prs.get_child(id).modulate = Color(0,1,0)
			else:
				prs.get_child(id).modulate = Color(1,0,0)
		"handler":
			hnd.get_child(id).text = type + " " + str(id)
			if works:
				hnd.get_child(id).modulate = Color(0,1,0)
			else:
				hnd.get_child(id).modulate = Color(1,0,0)
