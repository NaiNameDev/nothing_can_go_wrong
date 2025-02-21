extends Node3D

@export var quota_item: Pickable

func _ready() -> void:
	$add_area.connect("on_press", on_press)

func on_press(pick_me: Pickable):
	if pick_me == quota_item and GlobalVariables.day:
		GlobalVariables.gl_qt_now -= 1
		EventBus.added.emit()
		GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/adding.wav", self, -5)
