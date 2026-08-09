class_name CameraZoomer extends Camera2D

@export var og_zoom: Vector2


var tween:Tween



func _ready() -> void:
	BPMHandler.beat_hit.connect(beater)
	
func beater(cur:int):
	print(cur)
	if cur % BPMHandler.beat_every == 0:
		if tween:
			tween.kill()
		zoom = Vector2(og_zoom.x+0.015, og_zoom.y+0.015)
		tween = create_tween()
		tween.tween_property(self, "zoom", og_zoom, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.play()
		
