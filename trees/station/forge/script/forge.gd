extends Node3D

@export var station_id: int = 0
@export var station_name: String
@export var works: bool = true
@onready var add_area: Node3D = $add_area

@export_category("names")
@export var first_res_name: String
@export var second_res_name: String

@export_category("first res")
@export var first_res_left: float = 0:
	set(v):
		if v > first_res_max:
			first_res_left = first_res_max
		else:
			first_res_left = v
		
		if v <= 0.0:
			first_res_left = 0
			works = false
			EventBus.forge_break.emit(station_id, "out of " + first_res_name, station_name)
@export var first_res_max: float = 1.0
@export var first_res_per_second: float = 0.005

@export_category("second res")
@export var second_res_left: float = 0:
	set(v):
		if v > second_res_max:
			second_res_left = second_res_max
		else:
			second_res_left = v
		
		if v <= 0.0:
			second_res_left = 0
			works = false
			EventBus.forge_break.emit(station_id, "out of " + second_res_name, station_name)
@export var second_res_max: float = 1.0
@export var second_res_per_second: float = 0.005

@export_category("strength res")
@export var strength_left: float = 1.0:
	set(v):
		if v > strength_max:
			strength_left = strength_max
		else:
			strength_left = v
		
		if v <= 0.0:
			strength_left = 0
			works = false
			EventBus.forge_break.emit(station_id, station_name + " broked", station_name)
@export var strength_max: float = 1.0
@export var strength_per_second: float = 0.001

@export_category("out")
@export var out: Pickable
@export var drop_place: Node3D
@export var out_now: float = 0.0: set = on_out_set
@export var out_max: float = 1.0
@export var out_per_second: float = 0.03

@export_category("other")
@export var allowed_loot_to_add: Array[Pickable]
@export var infoer: Node3D

@onready var light: Node3D = $forge/Cube_001
@onready var des_light: Node3D = $forge/Cube_002

@onready var light_light: Node3D = $OmniLight3D

var electrocity: bool = true

func _ready() -> void:
	add_area.connect("on_press", add_loot)
	
	EventBus.gl_event_timer.connect("timeout", tick)
	infoer.get_child(3).text = station_name + " id " + str(station_id)
	update_info()
	
	EventBus.connect("enable_disable_system", on_off)

func on_off(v: bool):
	if v:
		electrocity = true
	else:
		electrocity = false

func on_out_set(v):
	out_now = v
	
	if out_now > out_max and drop_place:
		GlobalFunctions.drop_item(drop_place.global_position, drop_place.global_position, out)
		out_now = 0

func update_info():
	infoer.get_child(0).text = str(first_res_left)
	infoer.get_child(1).text = str(second_res_left)
	infoer.get_child(2).text = str(strength_left)
	EventBus.update_info.emit(station_name, station_id, first_res_left, second_res_left, strength_left, works)

func tick():
	if works and electrocity:
		light_light.visible = true
		light.visible = true
		des_light.visible = false
		first_res_left -= first_res_per_second
		second_res_left -= second_res_per_second
		strength_left -= strength_per_second
		out_now += out_per_second
		
		update_info()
	else:
		light_light.visible = false
		des_light.visible = true
		light.visible = false

func add_loot(loot: Pickable):
	for i in allowed_loot_to_add.size():
		if loot == allowed_loot_to_add[i]:
			match i:
				0:
					first_res_left += loot.adding
					EventBus.added.emit()
				1:
					second_res_left += loot.adding
					EventBus.added.emit()
				2:
					strength_left += loot.adding
					EventBus.added.emit()
	if first_res_left > 0 and second_res_left > 0 and strength_left > 0:
		EventBus.forge_break.emit(station_id, "continue working", station_name)
		works = true
	
	update_info()
