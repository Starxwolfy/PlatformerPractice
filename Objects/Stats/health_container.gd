class_name HealthContainer extends Node

signal health_changed(cur:float, last:float, _change_face)

@export var max_health: float
@export var health: float


func clamp_health():
	health = clamp(health, 0.0, max_health)


func change_health(val: float, type: String, _change_face):
	var last_HP = health
	
	match type:
		"Multiply":
			health *= val
		"Divide":
			if val == 0.0:
				OS.alert("dude", "no. startizm. no")
				return 
			health /= val
		"Addition":
			health += val
		"Subtract":
			health -= val
		"Set":
			health = val
			
	clamp_health()
	health_changed.emit(health, last_HP, _change_face)
	
