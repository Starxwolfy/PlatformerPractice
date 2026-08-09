extends AnimationPlayer

func _ready() -> void:
	animation_finished.connect(_back_to_idle)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		play("Attack")
	
	
func _back_to_idle(anim) -> void:
	if anim == "Attack":
		play("Idle_Sword")
