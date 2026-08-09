class_name CoolnessBar extends TextureProgressBar

@export var coolness: CoolnessComponent
@export var health_bar: HealthBar
@export var og_pos_y: float

var time: float


func _ready() -> void:
	coolness.coolness_changed.connect(bar)
	get_window().size_changed.connect(func():
			og_pos_y = health_bar.position.y - 25)

	
func _process(delta: float) -> void:
	time += delta
	position.y = CoolUtils.sine_wave(og_pos_y, time, 3.0, 2.0)
func bar(cool):
	value = (coolness.coolnesspercent/coolness.max_coolness)*100
	
