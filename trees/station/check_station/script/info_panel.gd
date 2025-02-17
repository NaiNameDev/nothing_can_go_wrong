extends Node3D

@onready var coal_button: Node3D = $Button3D
@onready var scrap_button: Node3D = $Button3D2
@onready var oil_button: Node3D = $Button3D3
@onready var rep_kit_button: Node3D = $Button3D4
@export var dropper: Node3D

var coal = preload("res://trees/resource/pickable/resource/coal.tres")
var scrap = preload("res://trees/resource/pickable/resource/scrap.tres")
var oil = preload("res://trees/resource/pickable/resource/oil.tres")
var rep_kit = preload("res://trees/resource/pickable/resource/repair_kit.tres")

func _ready() -> void:
	coal_button.connect("on_press", buy_coal)
	scrap_button.connect("on_press", buy_scrap)
	oil_button.connect("on_press", buy_oil)
	rep_kit_button.connect("on_press", buy_rep_kit)

func buy_coal():
	GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, coal)

func buy_scrap():
	GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, scrap)

func buy_oil():
	GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, oil)

func buy_rep_kit():
	GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, rep_kit)
