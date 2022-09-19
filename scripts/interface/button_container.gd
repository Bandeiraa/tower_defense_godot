extends HBoxContainer

var pause_texture_path = preload("res://assets/interface/pause.png")
var resume_texture_path = preload("res://assets/interface/resume.png")
var speed_up_texture_path = preload("res://assets/interface/speed_up.png")
var speed_up_texture_normal_path = preload("res://assets/interface/speed_up_normal.png")

var can_play: bool = false
var is_playing: bool = false

func _ready() -> void:
	for button in get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", ["exited", button])
		button.connect("mouse_entered", self, "mouse_interaction", ["entered", button])
		
		
func on_button_pressed(button: TextureButton) -> void:
	match button.name:
		"Play":
			update_play_state(button)
			
		"SpeedUp":
			update_speed_up_state(button)
			
			
func mouse_interaction(state: String, button: TextureButton) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
			
		"entered":
			button.modulate.a = 0.5
			
			
func update_play_state(button: TextureButton) -> void:
	if not can_play:
		can_play = true
		is_playing = true
		get_tree().paused = false
		button.texture_normal = pause_texture_path
		get_tree().call_group("game_manager", "start_level")
		return
		
	if is_playing:
		is_playing = false
		get_tree().paused = true
		button.texture_normal = resume_texture_path
		return
		
	is_playing = true
	get_tree().paused = false
	button.texture_normal = pause_texture_path
	
	
func update_speed_up_state(button: TextureButton) -> void:
	var time_scale: float = Engine.time_scale
	if time_scale == 1.0:
		Engine.time_scale = 2.0
		button.texture_normal = speed_up_texture_path
		return
		
	Engine.time_scale = 1.0
	button.texture_normal = speed_up_texture_normal_path
	
	
func on_quit_button_pressed() -> void:
	var _change_scene: bool = get_tree().change_scene("res://scenes/interface/initial_screen.tscn")
	
