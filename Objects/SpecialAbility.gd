class_name SpecialAbility extends Node

var is_doable: bool = true
@export var me: Player
@export var custom_anim: AnimationPlayer
func stop():
	custom_anim.play("RESET")

func _unhandled_input(event: InputEvent) -> void:
	if not is_doable:
		return
	input(event)
func _process(delta: float) -> void:
	if not is_doable:
		return
	processer(delta)

func input(event: InputEvent) -> void:
	pass
func processer(delta:float) -> void:
	pass
