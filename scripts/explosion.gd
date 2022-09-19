extends AnimatedSprite

func _ready() -> void:
	play()
	
	
func on_animation_finished() -> void:
	queue_free()
