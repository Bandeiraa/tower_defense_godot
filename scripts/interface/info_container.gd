extends VBoxContainer

onready var gold: Label = get_node("Gold")
onready var health: Label = get_node("Health")

export(NodePath) onready var scroll_bar = get_node(scroll_bar) as ScrollContainer

func update_info_container() -> void:
	gold.text = "Gold: " + str(global_data.gold)
	health.text = "Health: " + str(global_data.health)
	
	scroll_bar.change_button_state()
