class_name CharacterSelectScreen extends ScrollContainer

const CHARACTERJSON = preload("res://Resources/characters.json")
@export var grid: GridContainer

func _ready() -> void:
	var data = CoolUtils.parse_json(CHARACTERJSON)
	for i in data:
			var charbutton = CharacterButton.new()
			charbutton.use_parent_material = true
			charbutton.character = i
			grid.add_child(charbutton)
