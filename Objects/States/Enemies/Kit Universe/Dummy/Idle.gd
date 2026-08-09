class_name DummyIdle extends BaseEnemyState
	
func enter(data: Variant = {}) -> void:
	super()
	
func _physics_update(delta:float) -> void:
	CoolUtils.apply_movement(delta, actor)
	CoolUtils.gravity(delta, actor)
	
	actor.move_and_slide()
