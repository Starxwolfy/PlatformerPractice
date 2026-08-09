extends Node



func _ready() -> void:
	get_viewport().size_changed.connect(_change)
	
func _change() -> void:
	get_tree().root.content_scale_factor = DisplayServer.screen_get_size().y / 1080.0 * 1.0
