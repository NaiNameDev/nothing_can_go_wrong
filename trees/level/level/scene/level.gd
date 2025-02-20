extends Node3D

@onready var a = [$mspawn1,$mspawn2,$mspawn3,$mspawn4]



func _ready() -> void:
	
	EventBus._ready()
	EventBus.connect("add_monstro", add_monstro)

func add_monstro(monstro):
	monstro.global_position = a.pick_random().global_position
