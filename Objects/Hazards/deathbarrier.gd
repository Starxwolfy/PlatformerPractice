class_name DeathPit extends Area2D

func _ready() -> void:
	body_exited.connect(kill)


func kill(body: BaseChar):
	if str(body.machine.get_state()) != "Dead":
		body.state.finished.emit("Dead")
