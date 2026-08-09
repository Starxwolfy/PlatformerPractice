class_name Idle extends Base_State

func _physics_update(delta:float) -> void:
	super(delta)
	CoolUtils.apply_movement(delta, char)
	CoolUtils.gravity(delta, char)
	
	if char.dir != 0:
		finished.emit("Walk")
	if not char.is_on_floor():
		finished.emit("Air")
