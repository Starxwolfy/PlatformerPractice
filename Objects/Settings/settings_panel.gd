class_name Settings_Panel extends VBoxContainer

@export var apply_button: Button 


func _ready() -> void:
	
	apply_button.pressed.connect(_save)
	
	for i in get_children():
		match i.get_class():
			"CheckBox", "CheckButton":
				i.toggled.connect(_apply.bind(i.name))
				i.button_pressed = Settings._get_specific_value(i.name)
				CoolUtils.translate_setting(i, i.text, i.tooltip_text)
			"HSlider", "VSlider":
				i.value_changed.connect(_apply.bind(i.name))
				i.value = Settings._get_specific_value(i.name)
			"OptionButton":
				i.item_selected.connect(_apply_with_option.bind(i.name, i))
				i.selected = CoolUtils.get_item_id(i, Settings._get_specific_value(i.name))
				

				
			
func _apply(value, nameof):
	
	Settings.queued_values.set(nameof, value)
	
func _apply_with_option(index:int, nameof:String, button:OptionButton):
	var text_value = button.get_item_text(index)
	Settings.queued_values.set(nameof, text_value)

func _save():
	Settings._save()
