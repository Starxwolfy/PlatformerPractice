class_name Regeneration extends StatusEffect





func _process(delta: float) -> void:
	super(delta)
	who.health.change_health(intesnity*delta, "Addition", false)
