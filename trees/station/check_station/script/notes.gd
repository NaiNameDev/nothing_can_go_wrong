extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("change_quota", change_quota)

func change_quota(v: int):
	match v:
		0:
			$info_panel/now_note.text = "enable generator!"
		1:
			$info_panel/now_note.text = "enable system"
		2:
			$info_panel/now_note.text = "work"
		3:
			pass
