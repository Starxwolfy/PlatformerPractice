class_name walk extends Base_State

@export var FACTOR = 400


func _physics_update(delta:float) -> void:
	super(delta)
	CoolUtils.apply_movement(delta, char)
	char.player.speed_scale = abs(char.velocity.x/FACTOR)
	
	
	
	if char.dir == 0:
		finished.emit("Idle")
	if not char.is_on_floor():
		finished.emit("Air")
	if (sign(char.velocity.x) != sign(char.dir)) and not char.dir == 0:
		finished.emit("Skid")
		
func exit() -> void:
	char.player.speed_scale = 1
	
