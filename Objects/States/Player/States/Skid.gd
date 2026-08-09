class_name skid extends walk

	
	
func _physics_update(delta:float) -> void:
	super(delta)
	char.player.speed_scale = 1
	if sign(char.velocity.x) == sign(char.dir):
		finished.emit("Walk")
	if not char.is_on_floor():
		finished.emit("Air")
