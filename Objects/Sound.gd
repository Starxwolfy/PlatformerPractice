class_name HitSound extends AudioStreamPlayer2D

func _ready() -> void:
	play()
	pitch_scale = randf_range(0.8, 1.2)
	finished.connect(queue_free)
