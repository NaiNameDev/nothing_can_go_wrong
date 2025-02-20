extends Node

var monstro = preload("res://trees/entity/monstr/scene/monstro.tscn")

var generator_state: bool = false

signal enable_disable_system(v: bool)

signal forge_break(id: int, cause: String, station_name: String)
signal added
signal update_info(type: String, id: int, res1: float, res2: float, res3: float, works: bool)

signal event_hapend
signal end_game

signal monster
signal lose
signal generator_down

signal add_monstro(a)

signal start_new_day

var dayend: bool = false

var monster_chanse: int = 200
var generator_down_chanse: int = 200

var monster_event: bool = false

var timer_to_day_end: Timer

var ZAEBALI_KASTILI_EBANIE: bool = false

var gl_event_timer: Timer

func _ready() -> void:
	if GlobalVariables.gl_day_counter == 1:
		GlobalVariables.gl_money = 300
	
	GlobalVariables.day = false
	connect("end_game", game_over_end_fucking_fuck_fuck)
	
	connect("start_new_day", f_start_new_day)
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
	
	dayend = false
	monster_event = false
	ZAEBALI_KASTILI_EBANIE = false
	generator_state = false
	
	await get_tree().create_timer(0.1).timeout
	print("here")
	enable_disable_system.emit(false)
	ZAEBALI_KASTILI_EBANIE = true

func game_over_end_fucking_fuck_fuck():
	get_tree().quit()

func gen_state_change(v: bool):
	if GlobalVariables.day == false and dayend == false and ZAEBALI_KASTILI_EBANIE == true:
		GlobalVariables.day = true
	if dayend == true:
		timer_to_day_end.stop()
	if GlobalVariables.day == true and dayend == false and timer_to_day_end.is_stopped() == true:
		timer_to_day_end.start()
	generator_state = v

var start_money: int = 300

func f_start_new_day():
	GlobalVariables.gl_money += GlobalVariables.gl_day_counter * 100
	GlobalVariables.add_quota()
	start_money = GlobalVariables.gl_money
	GlobalVariables.gl_day_counter += 1
	get_tree().change_scene_to_file("res://trees/level/level/scene/level.tscn")

func lose_time():
	timer_to_day_end.stop()
	lose.emit()

func day_end():
	dayend = true
	GlobalVariables.day = false
	timer_to_day_end.stop()

func random_event():
	if !monster_event and GlobalVariables.day == true:
		if randi_range(0, generator_down_chanse) == 1 and generator_state and GlobalVariables.gl_day_counter > 1:
			enable_disable_system.emit(false)
			generator_down.emit()
			print("gen")
		if randi_range(0, monster_chanse) == 1 and GlobalVariables.gl_day_counter > 2:
			monster.emit()
			var mns = monstro.instantiate()
			get_tree().root.add_child(mns)
			add_monstro.emit(mns)
			monster_event = true
			enable_disable_system.emit(false)
			print("atashi monstra")
