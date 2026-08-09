class_name FaceHandler extends Node

@export var face_parts: Array[Sprite2D]
@export var default_face_on_start: Dictionary[int, int]
@export var health_stat: HealthContainer
@export var hurt_expression: Dictionary[int, int]
@export var health_expressions: Dictionary[float, Dictionary]
@export var status_expressions: Dictionary[String, Dictionary]

var statuses: Array[StatusEffect]
var ignored_temporary: bool
var idle_face: String
var ignore_health: bool = false

var idle_face_cache: Dictionary
var cur_priority: int = -1

var timer: SceneTreeTimer

func _ready() -> void:
	_change_idle_face(default_face_on_start, "normal")
	health_stat.health_changed.connect(_health_based_off_expression)
	check_health(health_stat.health)
	
func _health_based_off_expression(cur, last, _change_face):
	var damage: float = last - cur
	check_health(cur)
	if damage > 0 and _change_face:
		_apply_temporary_face(hurt_expression, 1, 100)
		
func check_health(cur: float):
	if cur > 0 and not ignore_health:
		_change_idle_face(CoolUtils.get_closest_value(cur, health_expressions), "any")
	
	
func _change_frames(parts: Dictionary):
	print(parts)
	for i in parts:
		if i < face_parts.size():
			face_parts[i].frame = parts[i]


func _change_idle_face(parts: Dictionary, idle_name: String, ignore_temprary: bool = false):
	print(parts)
	ignored_temporary = ignore_temprary
	if ignored_temporary:
		cur_priority = -1
		if timer and timer.timeout.is_connected(_timer_done):
			timer.timeout.disconnect(_timer_done)
	if cur_priority <= -1 or ignored_temporary:
		_change_frames(parts)
	idle_face_cache = parts as Dictionary
	idle_face = idle_name
	
func set_idle_based_off_status(status: String):
	print(status)
	if status_expressions.has(status):
		ignore_health = true
		_change_idle_face(status_expressions.get(status), status, true)
	
func stop_idle_based_off_status():
	if statuses.is_empty():
		ignore_health = false
		check_health(health_stat.health)
	
func _apply_temporary_face(parts: Dictionary, duriation: float, priority: int):
	if priority < cur_priority or ignored_temporary:
		return 
	if timer and timer.timeout.is_connected(_timer_done):
		timer.timeout.disconnect(_timer_done)
		
	_change_frames(parts)
	cur_priority = priority
	timer = get_tree().create_timer(duriation)
	timer.timeout.connect(_timer_done.bind(priority))
	
func _timer_done(expired_priority: int):
	if expired_priority == cur_priority:
		cur_priority = -1
		_change_frames(idle_face_cache)
		
			
		
	
