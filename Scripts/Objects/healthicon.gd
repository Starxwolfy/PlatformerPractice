class_name HealthIcon extends Sprite2D

@export var amount_of_frames: int
@export var current_HP: HealthContainer
@export var frame_values:Dictionary[int, int] = {}
@export var posmaxmin: Curve
var tween: Tween


func get_cloest_frame(thresholds: Dictionary) -> int:
	var percent = current_HP.health/current_HP.max_health*100
	var closest_number = -1
	var smallest_difference = INF
	for frame_id in thresholds:
		var target_percent = thresholds[frame_id]
		var diff = abs(percent-target_percent)
		if diff < smallest_difference:
			smallest_difference = diff
			closest_number = frame_id
			
	return closest_number
	
func _ready() -> void:
	BPMHandler.beat_hit.connect(beat_hit)
	hframes = amount_of_frames
	current_HP.health_changed.connect(change_icon)
	frame = get_cloest_frame(frame_values)
	
func beat_hit(cur):
	if tween:
		tween.kill()
	if owner is not Player:
		print("no D:")
		return
		
	scale = Vector2(1.2, 1.2)
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.play()
	
func change_icon(_cur, _last, _change_face):
	frame = get_cloest_frame(frame_values)
	var percent = current_HP.health/current_HP.max_health
	position.x = posmaxmin.sample(percent)
	
	
	
