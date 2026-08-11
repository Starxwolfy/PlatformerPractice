class_name Settings_Panel extends VBoxContainer

@export var apply_button: Button 
var boolean_types = [CheckBox, CheckButton]
var value_types = [HSlider, VSlider]


func _ready() -> void:
	apply_button.pressed.connect(_save)
	
	for i in get_children():
		match i.get_class():
			"CheckBox", "CheckButton":
				i.toggled.connect(_apply.bind(i.name))
				i.button_pressed = Settings._get_specific_value(i.name)
			"HSlider", "VSlider":
				i.value_changed.connect(_apply.bind(i.name))
				i.value = Settings._get_specific_value(i.name)
				
	
			
func _apply(value, nameof):
	Settings.queued_values.set(nameof, value)

func _save():
	Settings._save()
