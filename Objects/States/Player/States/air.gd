class_name Air extends Base_State

@export var raycast: ShapeCast2D


func enter(data: Variant = {}) -> void:
	super()
	raycast.enabled = true
func _update(delta: float) -> void:
	super(delta)
	if Input.is_action_just_released("JumpP1") and not char.jump_buffer.is_stopped():
		char.velocity.y = char.velocity.y * 0.5
	CoolUtils.apply_movement(delta, char)
	CoolUtils.gravity(delta, char)
	
	if char.is_on_floor():
		raycast.enabled = false
		finished.emit("Idle")
	if raycast.is_colliding():
		finished.emit("Wall")
