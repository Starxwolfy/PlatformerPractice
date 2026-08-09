class_name Spikes extends Area2D
@export var stats: HitboxData

func _ready() -> void:
	area_entered.connect(bleeder)
	
func bleeder(body: hurtbox):
	if body is hurtbox:
		body.deal_damage(stats, 0, self)
		CoolUtils.apply_status("Bleeding", 5, 2, body.character)
