class_name StatsText extends Label

@export var HP: HealthContainer

func _ready() -> void:
	HP.health_changed.connect(hp)
	hp(HP.health, 0, false)
	
func hp(cur, last, change_face):
	text = tr("KEY_SCORE").format(
	{"score": 0, 
	"health": int(HP.health),
	"max_health": int(HP.max_health)})
