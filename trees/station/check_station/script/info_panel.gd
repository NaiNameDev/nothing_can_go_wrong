extends Node3D

@onready var coal_button: CharacterBody3D = $for_poweroff/Button3D
@onready var scrap_button: CharacterBody3D = $for_poweroff/Button3D2
@onready var oil_button: CharacterBody3D = $for_poweroff/Button3D3
@onready var rep_kit_button: CharacterBody3D = $for_poweroff/Button3D4
@onready var box_button: CharacterBody3D = $for_poweroff/Button3D5
@onready var shot_gun_button: CharacterBody3D = $for_poweroff/Button3D6
@onready var shot_gun_ammo_button: CharacterBody3D = $for_poweroff/Button3D7
@export var dropper: Node3D
@export var dropper2: Node3D

var coal = preload("res://trees/resource/pickable/resource/coal.tres")
var scrap = preload("res://trees/resource/pickable/resource/scrap.tres")
var oil = preload("res://trees/resource/pickable/resource/oil.tres")
var rep_kit = preload("res://trees/resource/pickable/resource/repair_kit.tres")
var box = preload("res://trees/resource/pickable/resource/box.tres")
var shot_gun = preload("res://trees/resource/pickable/resource/pick_me_shot_gun.tres")
var shot_gun_ammo = preload("res://trees/resource/pickable/resource/ammo.tres")

func _ready() -> void:
	GlobalVariables.connect("money_changed", gl_money_changed)
	
	coal_button.connect("on_press", buy_coal)
	scrap_button.connect("on_press", buy_scrap)
	oil_button.connect("on_press", buy_oil)
	rep_kit_button.connect("on_press", buy_rep_kit)
	box_button.connect("on_press", buy_box)
	shot_gun_button.connect("on_press", buy_shot_gun)
	shot_gun_ammo_button.connect("on_press", buy_shot_gun_ammo)
	
	EventBus.connect("enable_disable_system", on_off)

var can = true

func gl_money_changed(v: int):
	print("penis")
	$for_poweroff/Label3D2.text = "you have " + str(v)+ "$"

func on_off(v: bool):
	if v:
		can = true
		$for_poweroff.visible = true
	else:
		can = false
		$for_poweroff.visible = false

func buy_coal():
	if can and 0 < (GlobalVariables.gl_money - 4):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, coal)
		GlobalVariables.gl_money -= 4

func buy_scrap():
	if can and 0 < (GlobalVariables.gl_money - 5):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, scrap)
		GlobalVariables.gl_money -= 5

func buy_oil():
	if can and 0 < (GlobalVariables.gl_money - 15):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, oil)
		GlobalVariables.gl_money -= 15

func buy_rep_kit():
	if can and 0 < (GlobalVariables.gl_money - 30):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, rep_kit)
		GlobalVariables.gl_money -= 30

func buy_box():
	if can and 0 < (GlobalVariables.gl_money - 3):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, box)
		GlobalVariables.gl_money -= 3

func buy_shot_gun():
	if can and 0 < (GlobalVariables.gl_money - 100):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, shot_gun)
		GlobalVariables.gl_money -= 100

func buy_shot_gun_ammo():
	if can and 0 < (GlobalVariables.gl_money - 50):
		GlobalFunctions.drop_item(dropper.global_position, dropper2.global_position, shot_gun_ammo)
		GlobalVariables.gl_money -= 50
