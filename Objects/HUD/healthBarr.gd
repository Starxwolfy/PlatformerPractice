class_name HealthBar extends TextureProgressBar

@export var health: HealthContainer
@export var health_icon: HealthIcon

var tween:Tween

func _ready() -> void:

	if health:
		health.health_changed.connect(sethpbar)
		tint_progress = CoolUtils.get_dominant_color(health_icon.texture)
		

	
	
func sethpbar(_cur, _last, _change_face):
	var per = health.health/health.max_health*100
	value = per
