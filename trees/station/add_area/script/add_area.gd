extends CharacterBody3D

@export var to_who: Node3D

func add_loot(loot: Pickable):
	if to_who:
		to_who.add_loot(loot)
