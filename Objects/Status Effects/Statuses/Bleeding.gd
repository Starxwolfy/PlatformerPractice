class_name Bleeding extends StatusEffect
var time_passed: float

func _ready() -> void:
	super()
	BPMHandler.beat_hit.connect(hit)

func _process(delta: float) -> void:
	super(delta)
		
func hit(cur):
	if who.health.health <= 10:
		queue_free()
		return
	var damage: float = intesnity*BPMHandler.formula if BPMHandler.formula < 1 else intesnity/BPMHandler.formula
	who.health.change_health(damage, "Subtract", false)
