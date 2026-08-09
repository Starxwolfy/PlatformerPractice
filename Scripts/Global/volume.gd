extends Node

var muted = false
var vol = 0.0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("VolMUTE"):
		muted = !muted
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted)

	if Input.is_action_just_pressed("VolUP"):
		vol = clamp(vol + 2.0, -80.0, 0.0)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), vol)
		muted = false
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted)
	if Input.is_action_just_pressed("VolDOWN"):
		vol = clamp(vol - 2.0, -80.0, 0.0)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), vol)
		muted = false
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted)
