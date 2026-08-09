class_name StatsText extends Label

@export var HP: HealthContainer

func _ready() -> void:
	HP.health_changed.connect(hp)
	hp(HP.health, 0, false)
	
func hp(cur, last, change_face):
	var percent = HP.health/HP.max_health*100
	text = "Score: 0 -- HP: %d%% (%02d/%02d)" % [percent, HP.health, HP.max_health]
