extends Node3D

@onready var coal_button: CharacterBody3D = $for_poweroff/Button3D
@onready var scrap_button: CharacterBody3D = $for_poweroff/Button3D2
@onready var oil_button: CharacterBody3D = $for_poweroff/Button3D3
@onready var rep_kit_button: CharacterBody3D = $for_poweroff/Button3D4
@onready var box_button: CharacterBody3D = $for_poweroff/Button3D5
@onready var shot_gun_button: CharacterBody3D = $for_poweroff/Button3D6
@export var dropper: Node3D

var coal = preload("res://trees/resource/pickable/resource/coal.tres")
var scrap = preload("res://trees/resource/pickable/resource/scrap.tres")
var oil = preload("res://trees/resource/pickable/resource/oil.tres")
var rep_kit = preload("res://trees/resource/pickable/resource/repair_kit.tres")
var box = preload("res://trees/resource/pickable/resource/box.tres")
var shot_gun = preload("res://trees/resource/pickable/resource/pick_me_shot_gun.tres")

func _ready() -> void:
	coal_button.connect("on_press", buy_coal)
	scrap_button.connect("on_press", buy_scrap)
	oil_button.connect("on_press", buy_oil)
	rep_kit_button.connect("on_press", buy_rep_kit)
	box_button.connect("on_press", buy_box)
	shot_gun_button.connect("on_press", buy_shot_gun)
	
	EventBus.connect("enable_disable_system", on_off)

var can = true

func on_off(v: bool):
	if v:
		can = true
		$for_poweroff.visible = true
	else:
		can = false
		$for_poweroff.visible = false

func buy_coal():
	if can:
		GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, coal)

func buy_scrap():
	if can:
		GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, scrap)

func buy_oil():
	if can:
		GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, oil)

func buy_rep_kit():
	if can:
		GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, rep_kit)

func buy_box():
	if can:
		GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, box)

func buy_shot_gun():
	if can:
		GlobalFunctions.drop_item(dropper.global_position, dropper.global_position, shot_gun)
