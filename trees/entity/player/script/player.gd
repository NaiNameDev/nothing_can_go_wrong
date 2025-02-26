extends CharacterBody3D

@export var speed: int = 3
@export var can_move: bool = true
@export var camera: Camera3D

@export var place_for_hand: Node3D
@export var action_ray: RayCast3D
@export var throw_target: Node3D

var ammo_have: int = 0
var ammo_max: int = 2
var ammo_load: int = 0
@export var shotgun: Pickable
@export var ammo: Pickable

var hand_buffer: Pickable = null: set = on_item_set

@export var guide = false

var step_gete: bool = true

func _ready() -> void:
	GlobalVariables.player = self
	
	EventBus.connect("added", added)
	
	GlobalVariables.connect("win_day", day_end)
	EventBus.connect("monster", monster)
	EventBus.connect("generator_down", gena_down)
	EventBus.connect("lose", death)
	
	if GlobalVariables.gl_day_counter == 1 and guide == false:
		GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/hello.wav", self, -20)
	

func _physics_process(delta: float) -> void:
	print(EventBus.timer_to_day_end.time_left)
	
	if not is_on_floor(): velocity += get_gravity() * delta
	if can_move: move()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") and hand_buffer == shotgun:
		shot()
	
	if action_ray.get_collider():
		$debug_canvas/Sprite2D2.visible = true
		if Input.is_action_just_pressed("action"):
			if action_ray.get_collider().is_in_group("item") and !hand_buffer:
				hand_buffer = action_ray.get_collider().orig_pickable
				action_ray.get_collider().queue_free()
			elif action_ray.get_collider().is_in_group("item") and action_ray.get_collider().orig_pickable == ammo and hand_buffer == shotgun:
				ammo_have += 2
				action_ray.get_collider().queue_free()
				update_shotgun_info()
			if action_ray.get_collider().is_in_group("button"):
				action_ray.get_collider().on_press.emit()
			if action_ray.get_collider().is_in_group("add_button") and hand_buffer:
				action_ray.get_collider().on_press.emit(hand_buffer)
	else:
		$debug_canvas/Sprite2D2.visible = false
	
	if Input.is_action_just_pressed("back"):
		$debug_canvas/Control.visible = !$debug_canvas/Control.visible
		if $debug_canvas/Control.visible:
			velocity = Vector3.ZERO
			can_move = false
			$Camera3D.can = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			can_move = true
			$Camera3D.can = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_just_pressed("drop"):
		#GlobalFunctions.drop_item(camera.global_position, throw_target.global_position, load("res://trees/resource/pickable/resource/box_of_bolts.tres"))
		if hand_buffer:
			GlobalFunctions.drop_item(camera.global_position, throw_target.global_position, hand_buffer)
			hand_buffer = null
	if Input.is_action_just_pressed("reload"):
		reload()

func reload():
	if ammo_load != ammo_max:
		if ammo_have != 0:
			match ammo_load:
				0: 
					if ammo_have != 1:
						ammo_have -= 2
						ammo_load = 2
					else:
						ammo_have -= 1
						ammo_load += 1
				1:
					ammo_have -= 1
					ammo_load += 1
			update_shotgun_info()

func shot():
	if ammo_load > 0:
		GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/shoting.wav", self)
		$Camera3D/place/GPUParticles3D.emitting = true
		
		if $Camera3D/shot_ray.get_collider():
			$Camera3D/shot_ray.get_collider().get_parent().damage(1)
		ammo_load -= 1
		$Camera3D.rotate_x(45)
		update_shotgun_info()
		$Camera3D/place/GPUParticles3D/OmniLight3D.visible = true
		await get_tree().create_timer(0.3).timeout
		$Camera3D/place/GPUParticles3D/OmniLight3D.visible = false

func update_shotgun_info():
	$debug_canvas/Label2.text = str(ammo_load) + "/" + str(ammo_have)

func day_end():
	GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/day_end.wav", self, -20)

func monster():
	GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/monster_warn.wav", self, -20)

func fast_death():
	EventBus.timer_to_day_end.stop()
	GlobalVariables.gl_money = EventBus.start_money
	get_tree().change_scene_to_file("res://trees/UI/menu/control.tscn")

func death():
	EventBus.timer_to_day_end.stop()
	GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/replacing.wav", self, -20)
	await get_tree().create_timer(12).timeout
	get_tree().change_scene_to_file("res://trees/UI/menu/control.tscn")

func gena_down():
	GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/generator_down.wav", self, -20)

func on_item_set(v):
	hand_buffer = v
	
	if hand_buffer == shotgun:
		$debug_canvas/Label2.visible = true
		update_shotgun_info()
	else:
		$debug_canvas/Label2.visible = false
	
	if hand_buffer != null:
		$debug_canvas/Label.text = hand_buffer.name
		var a = hand_buffer.model.instantiate()
		place_for_hand.add_child(a)
	else:
		$debug_canvas/Label.text = ""
		place_for_hand.get_child(1).queue_free()

func added():
	GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/adding.wav", self, -10)
	hand_buffer = null

func move():
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		if step_gete:
			step_gete = false
			GlobalFunctions.play_sound(Vector3.ZERO, "res://trees/entity/player/media/sound/walkus.wav", self, -25)
			await get_tree().create_timer(0.6).timeout
			step_gete = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)


func _on_button_pressed() -> void:
	$Camera3D.can = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$debug_canvas/Control.visible = false
