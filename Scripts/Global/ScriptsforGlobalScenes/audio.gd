class_name AudioHandler extends Node

@export var audio_to_play_to: AudioStreamPlayer

var audio_stream_cache: AudioStream = null


func _change_song_to(audio:AudioStream, just_cache:bool = false) -> void:
	if just_cache:
		audio_stream_cache = audio
		return
	if audio != audio_stream_cache:
		audio_to_play_to.stream = audio
		audio_stream_cache = audio
		audio_to_play_to.play()
		
func _stop_song(clear_cache:bool = false):
	if clear_cache:
		audio_stream_cache = null
	audio_to_play_to.stop()
	
func _play_cache():
	if audio_stream_cache:
		audio_to_play_to.stream = audio_stream_cache
		audio_to_play_to.play()
	else:
		CoolUtils.handle_error(ERR_FILE_NOT_FOUND)
	
