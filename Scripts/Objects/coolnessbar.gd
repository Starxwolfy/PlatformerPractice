class_name CoolnessComponent extends Node

signal coolness_changed(cool)

@export var max_coolness: float

var coolnesspercent:float = 0.0:
	set(val):
		coolnesspercent = clamp(val, 0.0, max_coolness)
		coolness_changed.emit(val)
