class_name State extends Node

@export var actor: BaseChar

signal finished(last_state: String, data: Variant)

func enter(data: Variant = {}) -> void:
	pass
func exit() -> void:
	pass
func _ready() -> void:
	pass
func _handle_input(event: InputEvent):
	pass
func _update(delta: float) -> void:
	pass
func _physics_update(delta:float) -> void:
	pass
