extends Node3D

var dialogs = ["Now I will try to teach you\n how to play this game", 
"The first thing you need\n to do when you start playing is to\n turn on the generator", "the generator looks like this",
"To win you need to create\n a certain number of bolts" ,"Okay, and this is the store where\n you will buy things for your work",  "and opposite the store are all\n the workstations",
"with their help you will\n have to create bolts", "The first thing you need to do is\n melt the iron in the furnace\n (to interact with objects press LMB)", ""]

var stage: int = 1

var dialogs_s2 = ["Next you need to push it into\n the press along with the oil"]
var gare2 = true

var dialogs_s3 = ["then stuff what fell out of the press\n along with the box into the handler"]
var gare3 = true

var dialogs_s4 = ["now send the box with bolts into\n the pipe that is under the handler", 
"repeat the process the required\n number of times and you win!\n everything is simple and\n nothing can go wrong!", 
"after you complete your daily quota,\n turn off the generator and go to where\n you spawned to start a new day!", "good luck!"]
var gare4 = true

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	GlobalVariables.gl_money = 1000
	EventBus.enable_disable_system.emit(true)
	
	$shop2/forge.connect("done", stage2)
	$shop2/press.connect("done", stage3)
	$handler.connect("done", stage4)

var count = 0
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		match stage:
			1:
				if count < dialogs.size():
					$CanvasLayer/Label.text = dialogs[count]
					count += 1
					if count == 4:
						EventBus.enable_disable_system.emit(true)
						$Player.position = $Node3D.position
			2:
				if count < dialogs_s2.size():
					$CanvasLayer/Label.text = dialogs_s2[count]
					count += 1
			3:
				if count < dialogs_s3.size():
					$CanvasLayer/Label.text = dialogs_s3[count]
					count += 1
			4:
				if count < dialogs_s4.size():
					$CanvasLayer/Label.text = dialogs_s4[count]
					count += 1
				else:
					get_tree().change_scene_to_file("res://trees/UI/menu/control.tscn")

func stage2():
	
	if gare2 == true:
		$CanvasLayer/Label.text = "Congratulations, you have smelted\n your first iron ingot!"
		stage = 2
		count = 0
		gare2 = false

func stage3():
	if gare3 == true:
		$CanvasLayer/Label.text = "you did it buddy!"
		stage = 3
		count = 0
		gare3 = false

func stage4():
	if gare4 == true:
		$CanvasLayer/Label.text = "This is the whole production process!"
		stage = 4
		count = 0
		gare4 = false
