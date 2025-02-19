extends CharacterBody3D

@onready var agent = $NavigationAgent3D
@export var speed: int = 2

func _ready() -> void:
	$Area3D.connect("body_entered", on_touch)
	$Area3D.connect("body_exited", on_untouch)

func _physics_process(delta: float) -> void:
	update_pos(GlobalVariables.player.global_position)
	move()
	
	look_at(GlobalVariables.player.position)
	move_and_slide()

func move():
	var dir = (agent.get_next_path_position() - global_position).normalized()
	velocity = dir * speed

func update_pos(pos: Vector3):
	agent.target_position = pos

func on_touch(body: Node3D):
	body.monstro_touch.emit()

func on_untouch(body: Node3D):
	body.monstro_untouch.emit()


func _on_death_zone_body_entered(body: Node3D) -> void:
	body.fast_death()
