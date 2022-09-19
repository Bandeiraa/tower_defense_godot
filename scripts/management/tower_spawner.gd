extends Node2D

func instance_tower(scene_path: String, spawn_position: Vector2) -> void:
	var scene_to_instance = load(scene_path).instance()
	scene_to_instance.global_position = spawn_position
	scene_to_instance.is_placed = true
	add_child(scene_to_instance)
