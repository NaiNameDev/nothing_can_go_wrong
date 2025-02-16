extends Node

signal forge_break(id: int, cause: String, station_name: String)
signal added

var gl_event_timer: Timer
func _ready() -> void:
	gl_event_timer = Timer.new()
	gl_event_timer.wait_time = 0.5
	gl_event_timer.autostart = true
	add_child(gl_event_timer)
