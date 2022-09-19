extends Control

onready var buttons_container: VBoxContainer = get_node("ButtonsContainer")
onready var level_container: VBoxContainer = get_node("LevelContainer")

func _ready() -> void:
	for level_button in level_container.get_children():
		level_button.modulate = Color('#4b4b4b')
		if global_data.level_dict[level_button.name]["is_level_available"]:
			level_button.disabled = false
			level_button.modulate = Color('#ffffff')
			
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		
		
func on_button_pressed(button) -> void:
	match button.name:
		"Play":
			var _change_scene: bool = get_tree().change_scene("res://scenes/level/level_1.tscn")
			
		"Load":
			buttons_container.hide()
			level_container.show()
			
		"Quit":
			get_tree().quit()
			
		"Level1":
			var _change_scene: bool = get_tree().change_scene("res://scenes/level/level_1.tscn")
			
		"Level2":
			var _change_scene: bool = get_tree().change_scene("res://scenes/level/level_2.tscn")
			
		"Level3":
			var _change_scene: bool = get_tree().change_scene("res://scenes/level/level_3.tscn")
			
			
func mouse_interaction(button, state) -> void:
	if button.disabled:
		return
		
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
