extends CanvasLayer

const BUSY_CELL_ID: int = 14

onready var preview: Control = get_node("Preview")
onready var v_container: VBoxContainer = get_node("VContainer")
onready var scroll_bar: ScrollContainer = get_node("RightContainer/ScrollBar")

var scene_path: String
var preview_tower = null
var can_click: bool = true

export(Color) var available_cell_color
export(Color) var unavailable_cell_color

export(NodePath) onready var map_tile = get_node(map_tile) as TileMap
export(NodePath) onready var tower_ref = get_node(tower_ref) as Node2D

#func _ready() -> void:
	#print(map_tile.tile_set.get_tiles_ids())
	#print(map_tile.tile_set.tile_get_name(14))
	
	
func initiate_interface() -> void:
	scroll_bar.initiate_scroll_bar()
	v_container.update_info_container()
	
	
func on_button_pressed(button: Button) -> void:
	if not can_click:
		return
		
	var scene_preview = load(button.scene_path).instance()
	preview.add_child(scene_preview)
	preview_tower = scene_preview
	
	can_click = false
	scene_path = button.scene_path
	scene_preview.connect("placed", self, "on_tower_placed")
	
	
func _process(_delta: float) -> void:
	if not is_instance_valid(preview_tower):
		return
		
	preview_action()
	if Input.is_action_just_pressed("ui_cancel"):
		cancel_action()
		
		
func preview_action() -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var current_tile_to_world = map_tile.world_to_map(mouse_position)
	var tile_position = map_tile.map_to_world(current_tile_to_world)
	
	if map_tile.get_cellv(current_tile_to_world) == -1:
		preview_tower.update_debugger_tower(true, tile_position, available_cell_color)
		return
		
	preview_tower.update_debugger_tower(false, tile_position, unavailable_cell_color)
	
	
func on_tower_placed(placed_position: Vector2, gold_cost: int) -> void:
	tower_ref.instance_tower(scene_path, placed_position)
	global_data.gold -= gold_cost
	
	v_container.update_info_container()
	cancel_action()
	
	var cell_size: Vector2 = map_tile.cell_size
	var cell_position: Vector2 = placed_position / cell_size
	
	scroll_bar.change_button_state()
	map_tile.set_cellv(cell_position, BUSY_CELL_ID)
	
	
func cancel_action() -> void:
	scene_path = ""
	preview_tower = null
	
	for children in preview.get_children():
		children.queue_free()
		
	can_click = true
