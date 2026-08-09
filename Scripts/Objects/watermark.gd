class_name WaterMark extends Sprite2D
const PATH = "res://Watermark/watermark-%s.png"
@export var CHANGE_SCENE_TO: PackedScene
const FULLSIZE = Vector2(1, 1)
const ROT = 0
var curlang: String = "ja"
var tween: Tween
var fade_tween: Tween

func _ready() -> void:
	texture = load(PATH % curlang)
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", FULLSIZE, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation", ROT, 0.65).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.finished.connect(fade)
	
func fade():
	fade_tween = create_tween()
	fade_tween.tween_interval(1)
	fade_tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)
	fade_tween.set_parallel(true)
	fade_tween.tween_property(self, "scale", FULLSIZE*0, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	fade_tween.finished.connect(close)
	
func close():
	get_tree().change_scene_to_packed(CHANGE_SCENE_TO)
