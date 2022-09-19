extends Node2D

onready var map_manager: Path2D = get_node("MapPath")
onready var interface: CanvasLayer = get_node("Interface")

export(int) var gold = 100
export(int) var health = 100

export(String) var next_level_name
export(String) var next_level_scene_path

func _ready() -> void:
	global_data.gold = gold
	global_data.health = health
	
	interface.initiate_interface()
	var _game_over: bool = global_data.connect("game_over", self, "on_game_over")
	var _level_completed: bool = map_manager.connect("level_completed", self, "on_level_completed")
	#get_tree().call_group("gui", "initiate_interface")
	
	
func start_level() -> void:
	map_manager.start()
	
	
func on_game_over() -> void:
	var _reload: bool = get_tree().reload_current_scene()
	
	
func on_level_completed() -> void:
	global_data.level_dict[next_level_name]["is_level_available"] = true
	var _change_scene: bool = get_tree().change_scene(next_level_scene_path)
