class_name Stun extends Base_State
var stunned_for: float

func enter(data: Variant = {}) -> void:
	super()
	CoolUtils.set_doable(char.specials, false)
	stunned_for = data
	
func _physics_update(_delta:float) -> void:
	CoolUtils.gravity(_delta, char)
	char.move_and_slide()

	stunned_for -= 60*_delta
	
	if stunned_for < 0:
		finished.emit("Idle")
		
func exit() -> void:
	CoolUtils.set_doable(char.specials, true)
	stunned_for = 0
	
