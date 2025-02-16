extends Node3D

@export var station_id: int = 0
@export var station_name: String
@export var works: bool = true
@export var out: float = 0.05

@export_category("names")
@export var first_res_name: String
@export var second_res_name: String

@export_category("first res")
@export var first_res_left: float = 1.0:
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
@export var first_res_per_second: float = 0.01

@export_category("second res")
@export var second_res_left: float = 1.0:
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
@export var second_res_per_second: float = 0.01

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

@export_category("other")
@export var allowed_loot_to_add: Array[Pickable]
@export var infoer: Node3D

func _ready() -> void:
	EventBus.gl_event_timer.connect("timeout", tick)
	infoer.get_child(3).text = station_name + " id " + str(station_id)

func tick():
	if works:
		first_res_left -= first_res_per_second
		second_res_left -= second_res_per_second
		strength_left -= strength_per_second
		
		infoer.get_child(0).text = str(first_res_left)
		infoer.get_child(1).text = str(second_res_left)
		infoer.get_child(2).text = str(strength_left)

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
