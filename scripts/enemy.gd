extends PathFollow2D

var already_killed: bool = false

export(int) var health
export(int) var damage
export(int) var gold_bounty
export(int) var move_speed = 800

export(PackedScene) var effect

func _process(delta: float) -> void:
	offset += move_speed * delta
	
	
func update_health(value: int) -> void:
	health -= value
	if health <= 0:
		already_killed = true
		spawn_death_effect()
		
		global_data.update_gold(gold_bounty)
		queue_free()
		
		
func spawn_death_effect() -> void:
	var effect_to_instance = effect.instance()
	effect_to_instance.global_position = global_position
	get_tree().root.call_deferred("add_child", effect_to_instance)
	
	
func on_screen_exited() -> void:
	if already_killed:
		return
		
	global_data.update_health(damage)
	queue_free()
