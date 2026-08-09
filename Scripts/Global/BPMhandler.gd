class_name BPM extends Node

signal beat_hit(cur_beat: int)
 
var beats_per_minute: float = 0.0
var formula: float = 0.0
var beat_every: int = 4

var current_beat: int = 0
var time: float = 0

func _ready() -> void:
	formula = 60.0/beats_per_minute
func _change_BPM(bpm:float):
	beats_per_minute = bpm
	formula = 60.0/beats_per_minute


func _process(delta: float) -> void:
	time += delta

	
	if time >= formula:
		time -= formula
		current_beat += 1
		beat_hit.emit(current_beat)
	
	
	
	
