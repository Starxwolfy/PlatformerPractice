class_name SelfPositioningSprite2D extends AnimatedSprite2D


func _ready() -> void:
	frame_changed.connect(_pos)
	
func get_size() -> Rect2:
	var anim: String = animation
	var idx: int = frame
	var frames:SpriteFrames = sprite_frames
	
	var texture = frames.get_frame_texture(animation, idx)
	
	return Rect2(Vector2.ZERO, texture.get_size())
	
	
func _pos():
	offset.y = -get_size().size.y / 2
	
