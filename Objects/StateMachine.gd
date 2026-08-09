class_name statemachine extends Node


@export var inital_state: State

var states: Dictionary[String, State] = {}
var cur_state: State


func _ready() -> void:
	if not inital_state:
		assert(inital_state, "ERROR: %s doesn't have an inital state." % owner.name)
		get_tree().quit(65535) 
	for i in get_children():
		if i is State:
			states[i.name.to_pascal_case()] = i as State
			i.finished.connect(_transition)
			
	await owner.ready
	
	cur_state = inital_state
	
	cur_state.enter()

			
			
func _transition(state: String, data: Variant = {}):
	if not states.has(state):
		print("%s tried to use %s, which does not exist! Are you sure it exists?" % [owner.name, state])
		return
		
	cur_state.exit()
	cur_state = states[state]
	cur_state.enter(data)
	
func get_state():
	return cur_state.name
	
func _physics_process(delta: float) -> void:
	cur_state._physics_update(delta)
	
func _process(delta: float) -> void:
	cur_state._update(delta)

func _unhandled_input(event: InputEvent) -> void:
	cur_state._handle_input(event)

	
