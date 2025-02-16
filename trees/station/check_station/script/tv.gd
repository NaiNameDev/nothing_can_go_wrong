extends Node3D

@export var grid: GridContainer

func _ready() -> void:
	EventBus.connect("forge_break", forge_break)

func forge_break(id: int, cause: String, station_name: String):
	var new_text: Label = Label.new()
	new_text.text = station_name + " " + str(id) + ": " + str(cause)
	grid.add_child(new_text)
