class_name health_indicator extends AnimatedSprite2D

@export var healthval: HealthContainer

func _ready() -> void:
	healthval.health_changed.connect(_health_changer)
	
	
func _health_changer(current: float, last_health: float) -> void:
	var percent = current / healthval.max_health * 100
	if percent >= 75:
		play("High")
	elif percent < 75 and percent >= 50:
		play("Med")
	elif percent <= 25 and percent > 0:
		play("Low")
	else:
		if animation != "Dead":
			play("Dead")
