class_name SettingsBackEnd extends Node
const PATH = "user://settings.prac"
const DEFAULTS = preload("res://Scripts/Global/SettingsDefault/defaults.json")

signal done(values)

var saved_values: Dictionary[String, Variant] = {} 
var queued_values: Dictionary[String, Variant] = {}


func _ready() -> void:
	_load()
	
func _load() -> void:
	var settings
	if not FileAccess.file_exists(PATH):
		var json = CoolUtils.parse_json(DEFAULTS)
		for i in json:
			saved_values[str(i)] = json[str(i)]
		return
	settings = FileAccess.open(PATH, FileAccess.READ)
	var json_text = settings.get_as_text()
	print(json_text)
	var parsed = JSON.parse_string(json_text)
	if parsed is Dictionary:
		for key in parsed:
			saved_values[str(key)] = parsed[key]
	done.emit(saved_values)
		
func _get_specific_value(key: String):
	if saved_values.has(key) and saved_values.get(key) != null:
		return saved_values.get(key)
	else:
		var json = CoolUtils.parse_json(DEFAULTS)
		for i in json:
			if i == key:
				return json[key]
				
func contains_language_quene():
	if queued_values.has("Language"):
		Language.cur_lang = saved_values.get("Language", "en")
		get_tree().reload_current_scene()
	
func _save() -> void:
	if queued_values.is_empty():
		return
	for key in queued_values:
		saved_values[key] = queued_values[key]
	var settings = FileAccess.open(PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(saved_values)
	print(json_string)
	settings.store_string(json_string)
	settings.close()
	done.emit(saved_values)
	contains_language_quene()
	
	
