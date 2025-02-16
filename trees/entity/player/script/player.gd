extends CharacterBody3D

@export var speed: int = 3
@export var can_move: bool = true
@export var camera: Camera3D

@export var hand_buffer: Pickable
@export var action_ray: RayCast3D
@export var throw_target: Node3D

func _ready() -> void:
	EventBus.connect("added", added)

func _physics_process(delta: float) -> void:
	if not is_on_floor(): velocity += get_gravity() * delta
	if can_move: move()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if action_ray.get_collider():
			match action_ray.get_collider().name:
				"add_area": if hand_buffer: 
					action_ray.get_collider().add_loot(hand_buffer)
				"dropped_item": if !hand_buffer:
					hand_buffer = action_ray.get_collider().orig_pickable
					action_ray.get_collider().queue_free()
	
	if Input.is_action_just_pressed("drop"):
		if hand_buffer:
			GlobalFunctions.drop_item(camera.global_position, throw_target.global_position, hand_buffer)
			hand_buffer = null

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
