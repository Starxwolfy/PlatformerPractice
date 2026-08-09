extends Control
var tween:Tween



func _ready() -> void:
	BPMHandler.beat_hit.connect(beater)
	pivot_offset = get_viewport_rect().size / 2
	
func beater(cur:int):
	print(cur)
	if cur % BPMHandler.beat_every == 0:
		if tween:
			tween.kill()
		scale = Vector2(1.05, 1.05)
		tween = create_tween()
		tween.tween_property(self, "scale", Vector2(1.0, 1.0), 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		
