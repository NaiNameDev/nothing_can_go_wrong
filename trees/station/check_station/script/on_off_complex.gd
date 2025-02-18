extends Node3D

var enable_state: bool = true

func _ready() -> void:
	$Button3D.connect("on_press", on_press)

func on_press():
	EventBus.enable_disable_system.emit(!enable_state)
