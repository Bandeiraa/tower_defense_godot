extends Area2D

signal placed

onready var tower: Sprite = get_node("Tower")
onready var muzzle_animation: AnimationPlayer = tower.get_node("MuzzleManager/Animation")

onready var attack_timer: Timer = get_node("AttackCooldown")

var enemies_list: Array = []

var is_placed: bool = false
var can_attack: bool = true
var can_process: bool = false

var is_position_available: bool = false

export(int) var damage
export(int) var gold_cost = 50

export(float) var attack_cooldown

func _ready() -> void:
	can_attack = true
	can_process = true
	
	
func update_debugger_tower(available: bool, world_position: Vector2, debugger_color: Color) -> void:
	modulate = debugger_color
	global_position = world_position
	is_position_available = available
	
	
func _process(_delta: float) -> void:
	place_tower()
	attack()
	
	
func place_tower() -> void:
	if not can_process:
		return
		
	if Input.is_action_just_pressed("ui_click") and is_position_available:
		emit_signal("placed", global_position, gold_cost)
		
		
func attack() -> void:
	if enemies_list.empty():
		return
		
	tower.look_at(enemies_list[0].global_position)
	
	if can_attack:
		muzzle_animation.play("fire")
		enemies_list[0].update_health(damage)
		attack_timer.start(attack_cooldown)
		can_attack = false
		
		
func on_tower_area_entered(area) -> void:
	if not is_placed:
		return
		
	if area.is_in_group("enemy"):
		enemies_list.append(area.get_parent())
		
		
func on_tower_area_exited(area) -> void:
	if not is_placed:
		return
		
	var area_index: int
	if area.is_in_group("enemy"):
		area_index = enemies_list.find(area.get_parent())
		
	if area_index != -1 and not enemies_list.empty():
		enemies_list.remove(area_index)
		
		
func on_attack_timer_timeout() -> void:
	can_attack = true
