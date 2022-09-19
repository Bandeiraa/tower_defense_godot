extends Path2D

signal level_completed

var enemy_count: int
var wave_index: int = 0

var enemy_spawn_cooldown: float

var current_wave: String
var wave_manager: Dictionary = {
	"wave_1": {
		"entity_list": [
			preload("res://scenes/entity/enemy/ship_a.tscn"),
			preload("res://scenes/entity/enemy/ship_b.tscn")
		],
		
		"wave_length": 90, #Seconds
		"wave_enemies": 135 
	}
}

func _ready() -> void:
	randomize()
	for children in get_children():
		if children is Timer:
			children.connect("timeout", self, "on_timer_timeout", [children])
			
			
func on_timer_timeout(timer: Timer) -> void:
	match timer.name:
		"WaveTimer":
			wave_timer_handler(timer)
			
		"SpawnTimer":
			spawn_timer_handler(timer)
			
			
func start() -> void:
	wave_timer_handler(get_node("WaveTimer"))
	
	
func wave_timer_handler(wave_timer: Timer) -> void:
	wave_index += 1
	current_wave = "wave_" + str(wave_index)
	if not wave_manager.has(current_wave):
		emit_signal("level_completed")
		return
		
	var wave_dict: Dictionary = wave_manager[current_wave]
	
	wave_timer.start(wave_dict["wave_length"])
	spawn_timer_handler(get_node("SpawnTimer"))
	
	
func spawn_timer_handler(spawn_timer: Timer) -> void:
	if not wave_manager.has(current_wave):
		return
		
	var wave_dict: Dictionary = wave_manager[current_wave]
	
	if enemy_count == wave_dict["wave_enemies"] - 1:
		enemy_count = 0
		return
		
	enemy_count += 1
	spawn_enemy(spawn_timer, wave_dict)
	
	
func spawn_enemy(spawn_timer: Timer, wave_dict: Dictionary) -> void:
	var enemies_list: Array = wave_dict["entity_list"]
	var random_enemy_index: int = randi() % enemies_list.size()
	var enemy_to_instance = enemies_list[random_enemy_index].instance()
	add_child(enemy_to_instance)
	
	var spawn_cooldown: float = wave_dict["wave_length"] / wave_dict["wave_enemies"]
	spawn_timer.start(spawn_cooldown)
