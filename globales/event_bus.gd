extends Node

signal enable_disable_system(v: bool)

signal forge_break(id: int, cause: String, station_name: String)
signal added
signal update_info(type: String, id: int, res1: float, res2: float, res3: float, works: bool)

signal event_hapend

signal day_end
signal monster
signal lose
signal generator_down

var monster_chanse: int = 300
var generator_down_chanse: int = 200

var eny_event: bool = false

var gl_event_timer: Timer
func _ready() -> void:
	gl_event_timer = Timer.new()
	gl_event_timer.wait_time = 0.5
	gl_event_timer.autostart = true
	gl_event_timer.connect("timeout", random_event)
	add_child(gl_event_timer)
	
	enable_disable_system.emit(false)

func random_event():
	if !eny_event:
		if randi_range(0, generator_down_chanse) == 1:
			generator_down.emit()
			event_hapend.emit()
			eny_event = true
			print("gen")
		if randi_range(0, monster_chanse) == 1:
			monster.emit()
			event_hapend.emit()
			eny_event = true
			print("atashi monstra")
