class_name ErrorGraphic extends TextureRect

var time: float = 0
@export var speed: float
@export var ampitude: float
@export var og_posy: float

func _process(delta: float) -> void:
	time += delta
	position.y = CoolUtils.sine_wave(og_posy, time, ampitude, speed)
