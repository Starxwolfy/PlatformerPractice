class_name PlayerHitBox extends Area2D


@export var me: Player
@export var dmg_adder: float
@export var values: HitboxData
@export var can_check:bool = false
	
func _physics_process(delta: float) -> void:
	if has_overlapping_areas() and can_check:
		for area in get_overlapping_areas():
			if area == self:
				pass
			if area is hurtbox:
				area.deal_damage(values, me.coolness.coolnesspercent, me)
				me.coolness.coolnesspercent += dmg_adder
				can_check = false
