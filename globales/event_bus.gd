extends Node

signal forge_break(id: int, cause: String, station_name: String)
signal added
signal update_info(type: String, id: int, res1: float, res2: float, res3: float, works: bool)

var gl_event_timer: Timer
func _ready() -> void:
	gl_event_timer = Timer.new()
	gl_event_timer.wait_time = 0.5
	gl_event_timer.autostart = true
	add_child(gl_event_timer)
