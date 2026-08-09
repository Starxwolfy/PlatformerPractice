class_name BaseEnemyState extends State


func enter(data: Variant = {}) -> void:
	actor.state = self
	actor.player.play(actor.machine.get_state())

func _update(delta: float) -> void:
	if actor.health.health <= 0 and str(actor.machine.get_state()) != "Dead":
		finished.emit("Dead")
