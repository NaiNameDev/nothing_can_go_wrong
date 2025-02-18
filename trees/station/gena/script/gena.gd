extends Node3D

@export var loot_to_repair: Pickable
var can_rapeir: bool = false

func _ready() -> void:
	$add_area.connect("on_press", on_touch)
	EventBus.connect("generator_down", on_break)

func on_break():
	can_rapeir = true

func on_touch(pick_me: Pickable):
	if pick_me == loot_to_repair and can_rapeir == true:
		EventBus.enable_disable_system.emit(true)
		can_rapeir = false
		EventBus.added.emit()
