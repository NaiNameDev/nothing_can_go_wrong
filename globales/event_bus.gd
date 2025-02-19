extends Node

var monstro = preload("res://trees/entity/monstr/scene/monstro.tscn")

var generator_state: bool = false

signal enable_disable_system(v: bool)

signal forge_break(id: int, cause: String, station_name: String)
signal added
signal update_info(type: String, id: int, res1: float, res2: float, res3: float, works: bool)

signal event_hapend

signal monster
signal lose
signal generator_down

signal add_monstro(a)

var dayend: bool = false

var monster_chanse: int = 200123123
var generator_down_chanse: int = 200

var monster_event: bool = false

var timer_to_day_end: Timer

var ZAEBALI_KASTILI_EBANIE: bool = false

var gl_event_timer: Timer
func _ready() -> void:
	GlobalVariables.connect("win_day", day_end)
	connect("enable_disable_system", gen_state_change)
	
	gl_event_timer = Timer.new()
	gl_event_timer.wait_time = 0.5
	gl_event_timer.autostart = true
	gl_event_timer.connect("timeout", random_event)
	add_child(gl_event_timer)
	
	timer_to_day_end = Timer.new()
	timer_to_day_end.wait_time = GlobalVariables.gl_daly_qt_max * 50
	add_child(timer_to_day_end)
	timer_to_day_end.connect("timeout", lose_time)
	
	await get_tree().create_timer(0.1).timeout
	enable_disable_system.emit(false)
	ZAEBALI_KASTILI_EBANIE = true

func gen_state_change(v: bool):
	if dayend == true:
		timer_to_day_end.stop()
	if GlobalVariables.day == true and dayend == false and timer_to_day_end.is_stopped() == true:
		timer_to_day_end.start()
	if GlobalVariables.day == false and dayend == false and ZAEBALI_KASTILI_EBANIE == true:
		GlobalVariables.day = true
	generator_state = v

func lose_time():
	timer_to_day_end.stop()
	lose.emit()

func day_end():
	dayend = true
	GlobalVariables.day = false
	timer_to_day_end.stop()

func random_event():
	if !monster_event:
		if randi_range(0, generator_down_chanse) == 1 and generator_state and GlobalVariables.day == true:
			enable_disable_system.emit(false)
			generator_down.emit()
			print("gen")
		if randi_range(0, monster_chanse) == 1 and GlobalVariables.day == true:
			monster.emit()
			var mns = monstro.instantiate()
			get_tree().root.add_child(mns)
			add_monstro.emit(mns)
			monster_event = true
			enable_disable_system.emit(false)
			print("atashi monstra")
