extends Button

onready var price: Label = get_node("Label")
onready var base: TextureRect = get_node("Base")
onready var tower: TextureRect = get_node("Tower")

var gold_cost: int
var scene_path: String

func initiate_slot(tower_scene_path: String, cost: int, base_path: String, tower_path: String) -> void:
	gold_cost = cost
	scene_path = tower_scene_path
	
	base.texture = load(base_path)
	tower.texture = load(tower_path)
	
	price.text = "Cost: " + str(cost)
	
	
func change_state(state: String) -> void:
	if state == "enable":
		modulate.a = 1.0
		disabled = false
		return
		
	disabled = true
	modulate.a = 0.5
