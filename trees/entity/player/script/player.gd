extends CharacterBody3D

@export var speed: int = 3
@export var can_move: bool = true
@export var camera: Camera3D

@export var place_for_hand: Node3D
@export var action_ray: RayCast3D
@export var throw_target: Node3D

var hand_buffer: Pickable = null: set = on_item_set

func _ready() -> void:
	EventBus.connect("added", added)

func _physics_process(delta: float) -> void:
	if not is_on_floor(): velocity += get_gravity() * delta
	if can_move: move()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if action_ray.get_collider():
		$debug_canvas/Sprite2D2.visible = true
		if Input.is_action_just_pressed("action"):
			if action_ray.get_collider().is_in_group("item") and !hand_buffer:
				hand_buffer = action_ray.get_collider().orig_pickable
				action_ray.get_collider().queue_free()
			if action_ray.get_collider().is_in_group("button"):
				action_ray.get_collider().on_press.emit()
			if action_ray.get_collider().is_in_group("add_button") and hand_buffer:
				action_ray.get_collider().on_press.emit(hand_buffer)
	else:
		$debug_canvas/Sprite2D2.visible = false
	
	if Input.is_action_just_pressed("drop"):
		if hand_buffer:
			GlobalFunctions.drop_item(camera.global_position, throw_target.global_position, hand_buffer)
			hand_buffer = null

func on_item_set(v):
	hand_buffer = v
	
	if hand_buffer != null:
		$debug_canvas/Label.text = hand_buffer.name###DEBUG
		var a = hand_buffer.model.instantiate()
		place_for_hand.add_child(a)
	else:
		$debug_canvas/Label.text = ""###DEBUG
		place_for_hand.get_child(0).queue_free()

func added():
	hand_buffer = null

func move():
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
