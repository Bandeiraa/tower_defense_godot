extends Node

signal game_over

var level_dict: Dictionary = {
	"Level1": {
		"level_path": "res://scenes/level/level_1.tscn",
		"is_level_available": true
	},
	
	"Level2": {
		"level_path": "res://scenes/level/level_2.tscn",
		"is_level_available": false
	},
	
	"Level3": {
		"level_path": "res://scenes/level/level_3.tscn",
		"is_level_available": false
	}
}

var gold: int
var health: int

func update_health(value: int) -> void:
	health -= value
	if health <= 0:
		health = 0
		emit_signal("game_over")
		
	get_tree().call_group("info_container", "update_info_container")
	
	
func update_gold(value: int) -> void:
	gold += value
	get_tree().call_group("info_container", "update_info_container")
