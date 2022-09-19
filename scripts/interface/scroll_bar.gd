extends ScrollContainer

const SLOT_BUTTON: PackedScene = preload("res://scenes/interface/slot_button.tscn")

onready var grid_container: GridContainer = get_node("Market")

var buttons_dictionary: Dictionary = {
	"button_1": {
		"tower_price": 50,
		"tower_scene_path": "res://scenes/entity/ally/tower_1.tscn",
		"base_texture_path": "res://assets/turrets/base/base_1.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_1.png"
	},
	
	"button_2": {
		"tower_price": 100,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_2.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_2.png"
	},
	
	"button_3": {
		"tower_price": 150,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_3.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_3.png"
	},
	
	"button_4": {
		"tower_price": 200,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_4.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_4.png"
	},
	
	"button_5": {
		"tower_price": 250,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_1.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_5.png"
	},
	
	"button_6": {
		"tower_price": 300,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_2.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_6.png"
	},
	
	"button_7": {
		"tower_price": 350,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_3.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_7.png"
	},
	
	"button_8": {
		"tower_price": 400,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_4.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_8.png"
	},
	
	"button_9": {
		"tower_price": 450,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_1.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_9.png"
	},
	
	"button_10": {
		"tower_price": 500,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_2.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_10.png"
	},
	
	"button_11": {
		"tower_price": 550,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_1.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_10.png"
	},
	
	"button_12": {
		"tower_price": 600,
		"tower_scene_path": "",
		"base_texture_path": "res://assets/turrets/base/base_2.png",
		"tower_texture_path": "res://assets/turrets/tower/tower_9.png"
	}
}

export(NodePath) onready var interface = get_node(interface) as CanvasLayer

func initiate_scroll_bar() -> void:
	for button in buttons_dictionary.keys():
		spawn_button(buttons_dictionary[button])
		
	change_button_state()
	
	
func spawn_button(button_info: Dictionary) -> void:
	var button_to_instance = SLOT_BUTTON.instance()
	grid_container.add_child(button_to_instance)
	button_to_instance.connect("pressed", interface, "on_button_pressed", [button_to_instance])
	
	button_to_instance.initiate_slot(
		button_info["tower_scene_path"],
		button_info["tower_price"],
		button_info["base_texture_path"],
		button_info["tower_texture_path"]
	)
	
	
func change_button_state() -> void:
	for button in grid_container.get_children():
		if global_data.gold >= button.gold_cost:
			button.change_state("enable")
			
		if not global_data.gold >= button.gold_cost:
			button.change_state("")
