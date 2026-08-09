class_name EnemyStun extends BaseEnemyState

var stunned_for: float

func enter(data: Variant = {}) -> void:
	super()
	actor.dir = 0
	actor.player.play("Stun")
	stunned_for = data
	print(actor.player.current_animation)
	


func _physics_update(delta:float) -> void:
	CoolUtils.apply_movement(delta, actor)
	CoolUtils.gravity(delta, actor)
	
	stunned_for -= 60.0*delta
	print(stunned_for)
	
	actor.move_and_slide()
	if stunned_for <= 0:
		finished.emit("Idle")
		
func exit() -> void:
	stunned_for = 0
	
