class_name SelfNamingPanel extends Control

@export var key_name: String

func _ready() -> void:
	name = tr(key_name)
