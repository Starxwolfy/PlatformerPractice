extends Camera2D

func _process(delta: float) -> void:
	position = get_viewport_rect().size/2 + (get_local_mouse_position()/15)
