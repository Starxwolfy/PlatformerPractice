class_name bumper extends Area2D
@export var h_speed: int = 0
@export var v_speed: int = 0
@export var stunned: int = 0
@export var damage: float = 0.0
@export var sfx: AudioStream
@onready var audio: AudioStreamPlayer2D = $S1B4


func _ready() -> void:
	body_entered.connect(_fly)
	
func _fly(body) -> void:
	var char = body as Player
	if not char:
		get_tree().change_scene_to_file("res://Scenes/ERROR.tscn")
		return
	if audio.stream != sfx:
		audio.stream = sfx
	audio.play()
	char.velocity = Vector2(h_speed*-char.graphic.scale.x, -v_speed)
	char.graphic.scale.x = -char.graphic.scale.x 
	char.state.finished.emit("Stun", stunned)
	char.health.change_health(damage, "Subtract")
