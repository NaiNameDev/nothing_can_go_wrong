extends Node3D

var enable_state: bool = false

func _ready() -> void:
	$Button3D.connect("on_press", on_press)

func on_press():
	if EventBus.monster_event == false and EventBus.dayend == false:
		EventBus.enable_disable_system.emit(!enable_state)
		enable_state = !enable_state
	elif EventBus.dayend == true:
		EventBus.enable_disable_system.emit(false)
