extends Path2D
class_name MapPath

onready var point_list: PoolVector2Array = curve.get_baked_points()

func _ready() -> void:
	global_data.point_list = point_list
