extends Sprite
class_name Enemy

onready var tween: Tween = get_node("Tween")

var index: int = 1
var point_list: PoolVector2Array 
var can_interpolate: bool = false

export(float) var move_speed = 0.01

func _ready() -> void:
	point_list = global_data.point_list
	can_interpolate = true
	
	
func _process(_delta: float) -> void:
	if can_interpolate:
		can_interpolate = false
		interpolate()
		
		
func interpolate() -> void:
	var _move: bool = tween.interpolate_property(
		self,
		"position",
		point_list[index - 1],
		point_list[index],
		move_speed
	)
	
	look_at(point_list[index])
	var _start: bool = tween.start()
	
	
func on_tween_finished() -> void:
	if index == point_list.size() - 1:
		return
		
	can_interpolate = true
	index += 1
