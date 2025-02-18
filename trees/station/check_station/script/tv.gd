extends Node3D

@export var grid: GridContainer

func _ready() -> void:
	EventBus.connect("forge_break", forge_break)
	EventBus.connect("enable_disable_system", on_off)

func on_off(v: bool):
	if v:
		$tv/Cube/Sprite3D.visible = true
	else:
		$tv/Cube/Sprite3D.visible = false

func forge_break(id: int, cause: String, station_name: String):
	var new_text: Label = Label.new()
	new_text.text = station_name + " " + str(id) + ": " + str(cause)
	grid.add_child(new_text)
	await get_tree().create_timer(30).timeout
	new_text.queue_free()
