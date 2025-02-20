extends Node

var dropped_item: PackedScene = preload("res://trees/resource/pickable/scene/dropped_item.tscn")

func drop_item(from: Vector3, to: Vector3, pick_me: Pickable):
	var tmpd: RigidBody3D = dropped_item.instantiate()
	tmpd.set_face(pick_me)
	tmpd.global_position = from + ((from - to).normalized()) * -1
	tmpd.linear_velocity = ((from - to).normalized() * 6) * -1
	tmpd.linear_velocity.y += 3
	tmpd.angular_velocity = Vector3(randf_range(0,3), randf_range(0,3), randf_range(0,3))
	get_tree().root.add_child(tmpd)

func play_sound(pos: Vector3, sound: String, add_to = null, volume: float = 0.0):
	if !add_to:
		add_to = get_tree().root
	var player: AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	player.position = pos
	player.stream = load(sound)
	add_to.add_child(player)
	player.max_db = volume
	player.play()
	await player.finished
	player.queue_free()
