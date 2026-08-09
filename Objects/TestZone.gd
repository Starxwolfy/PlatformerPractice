class_name Level extends Node2D

@export var starting_position: Vector2
@export var music: AudioStream
@export var music_bpm: float
@export var zoom_every: int


func _ready() -> void:
	BPMHandler._change_BPM(music_bpm)
	Audio._change_song_to(music, false)
	BPMHandler.beat_every = zoom_every
